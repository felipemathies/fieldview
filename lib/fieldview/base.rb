module Fieldview
	class Base
		include ActiveModel::Serializers::JSON
		
		attr_accessor :access_token

		def onwer(id)
			api_call(:resourceOwners, :get, id)
		end

		def boundary(id)
			api_call(:boundaries, :get, id)
		end

 		private

 		def api_call(resource, method, id = nil)
 			response = nil

 			if method == :get
 				path = "/#{resource.to_s}" 
 				path << "/#{id}" unless id.blank?

 				response = Fieldview::HttpService.get(path, self.access_token)
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