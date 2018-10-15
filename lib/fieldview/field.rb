module Fieldview
	class Field < Fieldview::Base

		attr_accessor :id, :name, :boundary_id, :resource_owner_id

		def self.path(all = false)
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
	end
end