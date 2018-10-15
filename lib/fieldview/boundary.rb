module Fieldview
	class Boundary < Fieldview::Base

		attr_accessor :geo_json_data

    def self.path(id)
      "/boundaries/#{id}"
    end

		def initialize(data)
			@geo_json_data = data
		end

		def as_json(options = {})
			self.geo_json_data.as_json(options)
		end
	end
end