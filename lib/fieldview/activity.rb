module Fieldview
  class Activity < Fieldview::Base
    attr_accessor :id, :start_time, :end_time, :created_at, :updated_at, :length, :field_ids, :access_token, :raw

    #abstract method
    def path(id)
    end

    #abstract method
    def get_resource
    end

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

    def content
      self.raw = api_call(self.get_resource, :get, id: self.id, is_binary_body: true)
    end
  end  
end  