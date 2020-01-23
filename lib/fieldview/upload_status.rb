module Fieldview
	class UploadStatus < Fieldview::Base

    UPLOADING = "UPLOADING"
    INVALID   = "INVALID"
    PENDING   = "PENDING"
    INBOX     = "INBOX"
    DECLINED  = "DECLINED"
    IMPORTING = "IMPORTING"
    SUCCESS   = "SUCCESS"

		def path(id)
			"/uploads/#{id}/status"
		end

		def initialize(attrs)
			attrs.each do |key, value|
        instance_variable_set("@#{key.to_s.underscore}", value)
			end
		end
	end
end