module Fieldview
	class Base

		attr_accessor :access_token

		def owner(id)
			api_call(:resourceOwners, :get, id)
		end

		def boundary(id)
			api_call(:boundaries, :get, id)
		end

		def planting_activity(id)
			api_call(:asPlanted, :get, nil, { 'resourceOwnerId' => resource_owner_id })
		end

		def zip(id)
			api_call(:asPlanted, :get, id) #setado manual para testes
		end

 		private

 		def api_call(resource, method, id = nil, params = {})
 			response = nil

 			if method == :get
 				path = ""
 				path << "/layers" if resource == :asPlanted
 				path << "/#{resource.to_s}"
 				path << "/#{id}" 	  unless id.blank?
 				path << "/contents" if resource == :asPlanted

 				if resource == :asPlanted
 					a = 1
 				end

 				response = Fieldview::HttpService.get(path, self.access_token, params, a)
 			end

 			api_response(resource, response)
 		end

 		def api_response(resource, response)
 			if response["results"]
 				response["results"].map do |attrs|
 					instantiate_resource(resource.to_s.singularize, attrs)
 				end
 			else
 				instantiate_resource(resource.to_s.singularize, response)
 			end
 		end

 		def instantiate_resource(resource, attrs)
 			Fieldview::Factory.new(resource, attrs.merge({access_token: self.access_token}))
 		end
	end
end