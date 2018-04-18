module Fieldview
	class Boundary < Fieldview::Base

		attr_accessor :geo_json_data, :id

		def initialize(data)
			@geo_json_data = data
		end

		def attributes
			{geo_json_data: self.geo_json_data}
		end

		def serializable_hash(options = nil)
			self.geo_json_data
		end

		def as_json
			self.geo_json_data.as_json
		end
	end
end