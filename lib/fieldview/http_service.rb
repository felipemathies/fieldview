module Fieldview
	class HttpService

		DEFAULT_HOST = "https://platform.climate.com"

		class << self
			def get(path, access_token, is_binary_body, params)
				req_path = append_path_api_version(path)

	 			response = service.get(req_path) do |req|

	 				headers = default_headers({"access_token" => access_token})

 					headers.merge!({'Range' => 'bytes=0-5242880'})           if is_binary_body
 					headers.merge!({'accept' => 'application/octet-stream'}) if is_binary_body

          params = {} unless params

	 				req.params.merge!(params)
 					req.headers.merge!(headers)
 				end

 				if response.status.to_i >= 400 && response.status.to_i < 500
          raise Fieldview::ClientError.new(response.status.to_i, response.body)
				end

 				if response.status.to_i >= 500
          raise Fieldview::ServerError.new(response.status.to_i, response.body)
				end

 				if response.status.to_i == 200 || response.status.to_i == 206
          result = nil

 					result = is_binary_body ? response.body : (JSON.parse response.body)
 				end

        result
 			end

			private

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
 		end
	end
end