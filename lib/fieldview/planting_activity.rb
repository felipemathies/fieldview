module Fieldview
  class PlantingActivity < Fieldview::Activity

    def path(id)
      id ? "layers/asPlanted/#{id}/contents" : "layers/asPlanted"
    end

    def resource
      self.class.name.demodulize
    end
  end
end