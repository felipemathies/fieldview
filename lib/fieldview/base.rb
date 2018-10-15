module Fieldview
	class Base

		attr_accessor :access_token

		def owner(id)
			api_call(:resourceOwners, :get, id: id)
		end

		def boundary(id)
			api_call(:boundaries, :get, id: id)
		end

 		private

    def api_call(resource, method, args = {})
      response = nil

      if :get == method
        path = create_path(resource, args[:id], args[:all])

        response = Fieldview::HttpService.get(path, self.access_token, args[:is_binary_body], args[:request_params])
      end

      if args[:is_binary_body]
        return response
      else
        return api_response(resource, response)
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
      path = Field.path(all)           if resource == :fields
      path = Boundary.path(id)         if resource == :boundaries
      path = PlantingActivity.path(id) if resource == :asPlanted

      path
    end

    def instantiate_resource(resource, attrs)
      resource = :plantingActivity if resource == 'asPlanted'

      Fieldview::Factory.new(resource, attrs.merge({access_token: self.access_token}))
    end
  end
end