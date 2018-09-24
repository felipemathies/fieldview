module Fieldview
	class Field < Fieldview::Base

		attr_accessor :id, :name, :boundary_id, :resource_owner_id

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

		def planting_activity
			# super(self.resource_owner_id)
			super('e72f2951-52fc-4776-adc8-e73e874f3e5e') #setado manual para testes
		end

		def zip
			super('9cc26411-cfa8-433f-bf51-92df0ac69a80') #setado manual para testes
		end
	end
end