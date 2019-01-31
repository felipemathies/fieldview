module Fieldview
  class HarvestActivity < Fieldview::Activity

    def path(id)
      id ? "layers/asHarvested/#{id}/contents" : "layers/asHarvested"
    end

    def get_resource
      :harvestActivity
    end

  end
end