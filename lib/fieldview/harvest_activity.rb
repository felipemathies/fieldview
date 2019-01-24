module Fieldview
  class HarvestActivity < Fieldview::Base

    attr_accessor :id, :start_time, :end_time, :created_at, :updated_at, :length, :field_ids, :access_token, :raw

    def path(id)
      id ? "layers/asHarvested/#{id}/contents" : "layers/asHarvested"
    end

    def initialize(attrs)
      attrs.each do |key, value|
        if key == "fieldIds"
          fields = []

          value.each do |fieldId|
            fields << Fieldview::Factory.new(:field, { id: fieldId })
          end
          
          instance_variable_set("@#{key.to_s.underscore}", fields)
        else
          instance_variable_set("@#{key.to_s.underscore}", value)
        end
      end
    end

    def content
      self.raw = api_call(:harvestActivity, :get, id: self.id, is_binary_body: true)
    end
  end
end