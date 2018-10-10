module Fieldview
	class Client < Fieldview::Base

		def initialize(token)
 			self.access_token = token
 		end

 		def fields(all = false)
 			api_call(resource: :fields, method: :get, all: all)
 		end

    def planting_activities(resource_owner_id)
      request_params = {
        :resourceOwnerId => resource_owner_id
      }

      api_call(resource: :asPlanted, method: :get, request_params: request_params)
    end

    def planting_activity_raw(planting_activity_id)
      api_call(resource: :asPlanted, method: :get, id: planting_activity_id, is_binary_body: true)
    end
	end
end