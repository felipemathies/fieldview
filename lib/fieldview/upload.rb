module Fieldview
	class Upload < Fieldview::Base

    attr_accessor :data, :resource_owner, :access_token, :content_type

		def path(id = nil)
			id ? "/uploads/#{id}" : "/uploads"
		end

    def initialize(attrs)
			attrs.each do |key, value|
        instance_variable_set("@#{key.to_s.underscore}", value)
			end
		end

		def self.upload(data, resource_owner, access_token, content_type)
			new(data: data, resource_owner: resource_owner, access_token: access_token, content_type: content_type).upload_chunks
		end

		def upload_chunks
			api_upload(:upload, :put, upload_id: upload_id, body: self.data)

			upload_id
		end

    private

		def upload_id
			@upload_id ||= api_upload(:upload, :post, args)
		end

		def args
			{
				headers: default_headers,
				body:    default_body
			}
		end

    def default_headers
      headers = {}
      headers['X-Recipient-Email'] = self.resource_owner.email
      
      headers
    end

    def default_body
      {
        md5:    		 Digest::MD5.hexdigest(self.data),
        length: 		 self.data.size,
				contentType: self.content_type
      }
    end
	end
end