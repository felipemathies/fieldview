module Fieldview
	class Client < Fieldview::Base

		def initialize(token)
 			self.access_token = token		
 		end

 		def fields(all = false)
 			api_call(:fields, :get, all ? "all" : nil)
 		end

    def planting_activities
    end
	end
end