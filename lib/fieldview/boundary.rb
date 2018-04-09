module Fieldview
	class Boundary < Fieldview::Base

		attr_accessor :geo_json_data

		def initialize(data)
			@geo_json_data = data
		end

		def to_json
			self.geo_json_data.to_json
		end
	end
end