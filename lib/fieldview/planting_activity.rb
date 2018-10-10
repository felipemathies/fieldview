module Fieldview
  class PlantingActivity < Fieldview::Base

    attr_accessor :id, :start_time, :end_time, :created_at, :updated_at, :length, :field_ids, :access_token, :raw

    def initialize(attrs)
      attrs.each do |key, value|
        if key == "fields"
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
  end
end