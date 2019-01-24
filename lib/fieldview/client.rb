module Fieldview
	class Client < Fieldview::Base

		def initialize(token)
 			self.access_token = token
 		end

 		def fields(all = false)
 			api_call(:field, :get, all: all)
 		end

    def planting_activities(resource_owner_id = nil, occurred_after = nil, occurred_before = nil, updated_after = nil)
      request_params = {}

      request_params["resourceOwnerId"] = resource_owner_id if resource_owner_id
      request_params["updatedAfter"]    = updated_after     if updated_after
      request_params["occurredBefore"]  = occurred_before   if occurred_before
      request_params["occurredAfter"]   = occurred_after    if occurred_after

      api_call(:plantingActivity, :get, request_params: request_params)
    end

    def harvest_activities(resource_owner_id = nil, occurred_after = nil, occurred_before = nil, updated_after = nil)
      request_params = {}

      request_params["resourceOwnerId"] = resource_owner_id if resource_owner_id
      request_params["updatedAfter"]    = updated_after     if updated_after
      request_params["occurredBefore"]  = occurred_before   if occurred_before
      request_params["occurredAfter"]   = occurred_after    if occurred_after

      api_call(:harvestActivity, :get, request_params: request_params)
    end
    
	end
end