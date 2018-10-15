module Fieldview
	class Client < Fieldview::Base

		def initialize(token)
 			self.access_token = token
 		end

 		def fields(all = false)
 			api_call(:fields, :get, all: all)
 		end

    def planting_activities(resource_owner_id)
      request_params = {
        :resourceOwnerId => resource_owner_id
      }

      api_call(:asPlanted, :get, request_params: request_params)
    end
	end
end