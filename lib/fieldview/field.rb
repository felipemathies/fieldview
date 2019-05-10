module Fieldview
	class Field < Fieldview::Base

		attr_accessor :id, :name, :boundary_id, :resource_owner_id, :parent

		def path(all = false)
			all ? "/fields/all" : "/fields"
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

		def farm_organization
			super(self.parent['id'])
		end
	end
end