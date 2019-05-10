module Fieldview
  class FarmOrganization < Fieldview::Base
    attr_accessor :id, :name

    def initialize(attrs)
      attrs.each do |key, value|
        instance_variable_set("@#{key.to_s.underscore}", value)
      end
    end

    def path(id)
      "/farmOrganizations/farm/#{id}"
    end
  end
end