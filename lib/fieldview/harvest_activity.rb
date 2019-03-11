module Fieldview
  class HarvestActivity < Fieldview::Activity

    def path(id)
      id ? "layers/asHarvested/#{id}/contents" : "layers/asHarvested"
    end

    def resource
      self.class.name.demodulize
    end

  end
end