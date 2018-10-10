module Fieldview
	class Base

		attr_accessor :access_token

		def owner(id)
			api_call(resource: :resourceOwners, method: :get, id: id)
		end

		def boundary(id)
			api_call(resource: :boundaries, method: :get, id: id)
		end

 		private

    def api_call(args = {})
      args[:is_binary_body] ||= nil
      args[:request_params] ||= {}
      response                = nil

      if :get == args[:method]
        path = create_path(args[:resource], args[:id], args[:all])

        response = Fieldview::HttpService.get(path, self.access_token, args[:is_binary_body], args[:request_params])
      end

      if args[:is_binary_body]
        return response
      else
        return api_response(args[:resource], response)
      end
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

  	def create_path(resource, id, all)
      path = ""

      path << (resource == :fields || resource == :boundaries ? "/#{resource.to_s}" : "layers/#{resource.to_s}")
      path << "/#{id}" if id
      path << "/all"   if all
      path << "/contents" if id && resource == :asPlanted

      path
    end

    def instantiate_resource(resource, attrs)
      resource = :plantingActivity if resource == 'asPlanted'

      Fieldview::Factory.new(resource, attrs.merge({access_token: self.access_token}))
    end
  end
end