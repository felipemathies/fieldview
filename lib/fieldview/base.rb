module Fieldview
	class Base

		attr_accessor :access_token

		def owner(id)
			api_call(:resourceOwner, :get, id: id)
		end

		def boundary(id)
			api_call(:boundary, :get, id: id)
		end

 		private

    def api_call(resource, method, args = {})
      response = nil

      if :get == method
        path = create_path(resource, args[:id] || args[:all])

        response = Fieldview::HttpService.get(path, self.access_token, args[:is_binary_body], args[:request_params])
      end

      if args[:is_binary_body]
        return response
      else
        return api_response(resource, response)
      end
    end

    def api_upload(resource, method, args = {})
      response = nil

      if method == :post
        path     = create_path(resource, nil)
        response = Fieldview::UploadService.post(path, self.access_token, args[:body], args[:headers])
      elsif method == :put
        path     = create_path(resource, args[:upload_id])
        response = Fieldview::UploadService.put(path, self.access_token, args[:body])
      end

      response
    end

 		def api_response(resource, response)
      if response.nil?
        return {}
      elsif response["results"]
 				response["results"].map do |attrs|
 					instantiate_resource(resource.to_s.singularize, attrs)
 				end
 			else
 				instantiate_resource(resource.to_s.singularize, response)
 			end
 		end

  	def create_path(resource, source)
       instance = Fieldview::Factory.new(resource)
       instance.path(source)
    end

    def instantiate_resource(resource, attrs)
      Fieldview::Factory.new(resource, attrs.merge({access_token: self.access_token}))
    end
  end
end