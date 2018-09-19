module Fieldview
  class PlantingActivity < Fieldview::Layer

    def self.planting_activities(resource_owner_id)
      api_call(:asPlanted, :get, nil, nil, { 'resourceOwnerId' => resource_owner_id })
    end

    def raw_planting_activities(id)
      api_call(:asPlanted, :get, id, true)
    end
  end
end