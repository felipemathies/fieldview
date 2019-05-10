require "fieldview/version"
require "fieldview/base"
require "fieldview/errors"
require "fieldview/client"
require "fieldview/field"
require "fieldview/resource_owner"
require "fieldview/boundary"
require "fieldview/field"
require "fieldview/http_service"
require "fieldview/factory"
require "fieldview/configuration"
require "fieldview/activity"
require "fieldview/planting_activity"
require "fieldview/harvest_activity"
require "fieldview/farm_organization"

module Fieldview
	class << self

		def configure
			yield config
		end

		def config
      @config ||= Configuration.new
		end
	end
end