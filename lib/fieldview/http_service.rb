module Fieldview
	class HttpService

		DEFAULT_HOST = "https://platform.climate.com"
    MAX_BINARY_BODY_RANGE = "5242880"

		class << self
			def get(path, access_token, is_binary_body, params = {}, header = {})
				result  = nil
				response = get_response(path, access_token, is_binary_body, params, header)

 				if response.status.to_i == 200 || response.status.to_i == 206
					result = extract_result(is_binary_body, response)
					
					if response.headers.has_key? "x-next-token"
						next_token = response.headers["x-next-token"]
						
						loop do
							next_response = get_response(path, access_token, is_binary_body, params, {'x-next-token' => next_token})

							if next_response.body
								next_result = extract_result(is_binary_body, next_response)
								result["results"].concat(next_result["results"]) if next_result
							end

							break if next_response.status.to_i == 304 || next_response.status.to_i == 200

							next_token  = next_response.headers["x-next-token"]
						end
					end
 				end

        result
 			end

			def service
 				Faraday.new(DEFAULT_HOST)
 			end

 			def default_headers(args = {})
 				default = {}
 				default['accept'] = 'application/json'
 				default['X-Api-Key'] = Fieldview.config.api_key
 				default["Authorization"] = "Bearer #{args["access_token"]}" if args["access_token"]
 				default
 			end

 			def append_path_api_version(path)
 				Fieldview.config.api_version + "/" + path
 			end
		
			def get_response(path, access_token, is_binary_body, params = {}, header = {})
				params ||= {}
				req_path = append_path_api_version(path)

				response = service.get(req_path) do |req|
					headers = default_headers({"access_token" => access_token})

					headers.merge!({'Cache-Control' => 'reload'})
					headers.merge!({'X-Limit' 			=> '100'})
					headers.merge!({'Range' 				=> "bytes=0-#{MAX_BINARY_BODY_RANGE}"}) if is_binary_body
					headers.merge!({'accept' 				=> 'application/octet-stream'})        	if is_binary_body
				 	headers.merge!(header)

					req.params.merge!(params)
					req.headers.merge!(headers)
				end

				check_response_status(response)

				response
			end

			def check_response_status(response)
				raise Fieldview::ServerError.new(response.status.to_i, response.body, "Request Limit") if response.status.to_i == 429
				raise Fieldview::ClientError.new(response.status.to_i, response.body) 								 if response.status.to_i >= 400 && response.status.to_i < 500
				raise Fieldview::ServerError.new(response.status.to_i, response.body)									 if response.status.to_i >= 500
			end

			def extract_result(is_binary_body, response)
				is_binary_body ? response.body : (JSON.parse(response.body))
			end
		end
	end
end