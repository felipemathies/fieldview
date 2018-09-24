module Fieldview
	class HttpService

		DEFAULT_HOST = "https://platform.climate.com"

		class << self
			def get(path, access_token, params = {}, a = nil)
				req_path = append_path_api_version(path)

	 			response = service.get(req_path) do |req|

	 				headers = default_headers({"access_token" => access_token})

 					headers.merge!({'Range' => 'bytes=0-1028111'}) if a
 					headers.merge!({'accept' => 'application/octet-stream'}) if a

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
 					if a
 						binary = response.body
            teste  = ''

 						File.open("#{Rails.root}/tmp/binary/binary.zip", "wb") do |file|
						  file.write(binary)
						end

						zip_file = Zip::ZipFile.open("#{Rails.root}/tmp/binary/binary.zip")

            zip_file.each do |entry|
              entry.extract("#{Rails.root}/tmp/binary/#{entry.name}") { true }
              
              File.open("#{Rails.root}/tmp/binary/#{entry.name}", "r") do |dat_file|
                teste << dat_file.read
              end
            end

            debugger
            puts "sadasd"
 					else
 						JSON.parse response.body 
 					end
 				end
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