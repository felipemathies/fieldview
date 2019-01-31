module Fieldview
  class PlantingActivity < Fieldview::Activity

    def path(id)
      id ? "layers/asPlanted/#{id}/contents" : "layers/asPlanted"
    end

    def get_resource
      :plantingActivity
    end
  end
end