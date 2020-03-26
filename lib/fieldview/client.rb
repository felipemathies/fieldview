module Fieldview
	class Client < Fieldview::Base

		def initialize(token)
 			self.access_token = token
 		end

 		def fields(all = false)
 			api_call(:field, :get, all: all)
    end

    def field(id)
      api_call(:field, :get, id: id)
    end

    def upload(data, resource_owner, content_type)
      Fieldview::Upload.upload(data, resource_owner, access_token, content_type)
    end

    def upload_status(upload_id)
      api_upload(:uploadStatus, :get, upload_id: upload_id)
    end
     
    def activities(resource, resource_owner_id = nil, occurred_after = nil, occurred_before = nil, updated_after = nil)
      request_params = {}

      request_params["resourceOwnerId"] = resource_owner_id if resource_owner_id
      request_params["updatedAfter"]    = date_formatter(updated_after) if updated_after
      request_params["occurredBefore"]  = date_formatter(occurred_before) if occurred_before
      request_params["occurredAfter"]   = date_formatter(occurred_after) if occurred_after

      api_call(resource, :get, request_params: request_params)
    end

    def authorized_access_resource?(resource, resource_owner_id = nil)
      request_params = {}

      request_params["resourceOwnerId"] = resource_owner_id if resource_owner_id
      request_params["updatedAfter"]    = date_formatter(Time.now - 10.seconds)
      
      begin
        api_call(resource, :get, request_params: request_params)
        return true
      rescue Fieldview::ClientError => exception
        return false if exception.http_status == 403 || exception.http_status == 401
      end
    end

    private

    def date_formatter(date)
      date.strftime("%FT%T\Z")
    end
	end
end