module Fieldview
  class Layer < Fieldview::Base

    def initialize(access_token)
      self.access_token = access_token
    end

    def planting_activities(resource_owner_id)
      PlantingActivity.new(access_token).planting_activities(resource_owner_id)
    end

    def api_call(resource, method, id = nil, raw = nil, params = {})
      response = nil

      if method == :get
        path = "layers/#{resource}"
        path << "/#{id}"    unless id.blank?
        path << "/contents" if raw

        response = Fieldview::HttpService.get(path, self.access_token, params)
      end

      api_response(resource, response)
    end
  end
end