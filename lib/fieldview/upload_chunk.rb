module Fieldview
	class UploadChunk < Fieldview::Base

		def path(id)
			"/uploads/#{id}"
		end

		def initialize(attrs)
			attrs.each do |key, value|
        instance_variable_set("@#{key.to_s.underscore}", value)
			end
		end
	end
end