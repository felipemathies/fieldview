# Global configuration for Koala.
module Fieldview
	class Configuration
		# The default API Key used for Throttling .
		attr_accessor :api_key

		def api_version
			"v4"
		end
	end
end