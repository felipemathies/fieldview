module Fieldview
	class Field < Fieldview::Base

		attr_accessor :id, :name, :boundary_id, :resource_owner_id

		def path(source = false)
			path = "/fields"			
			path = path + "/all" 			 if source.is_a?(Boolean) && source == true
			path = path + "/#{source}" unless source.is_a?(Boolean)

			path
		end

		def initialize(attrs)
			attrs.each do |key, value|
        instance_variable_set("@#{key.to_s.underscore}", value)
			end
		end

		def boundary
 			super(self.boundary_id)
		end

		def owner
			super(self.resource_owner_id)
		end
	end
end