module Fieldview
	class Upload < Fieldview::Base

		def path(args = {})
			"/uploads/#{args[:upload_id]}/status" if args[:id] && args[:status] 
      "/uploads/#{args[:upload_id]}"        if args[:id]
      "/uploads"
		end

    def initialize(attrs)
			attrs.each do |key, value|
        instance_variable_set("@#{key.to_s.underscore}", value)
			end
		end
	end
end