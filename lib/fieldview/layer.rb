module Fieldview
  class Layer

    attr_accessor :access_token

    def initialize(token)
      self.access_token = token
    end

    def planting_activities(resource_owner_id)
      api_call(:asPlanted, :get, nil, nil, { 'resourceOwnerId' => resource_owner_id })
    end

    def raw(planting_activity_id)
      api_call(:asPlanted, :get, planting_activity_id, true)
    end

    private

    def api_call(resource, method, id, is_binary_body, params = {})
      response = nil

      if method == :get
        path = "layers/#{resource.to_s}"
        path << "/#{id}"    if id
        path << "/contents" if id

        response = Fieldview::HttpService.get(path, self.access_token, is_binary_body, params)
      end

      api_response(resource, response)
    end

    def api_response(resource, response)
      if response["results"]
        response["results"].map do |attrs|
          instantiate_resource(:plantingActivity, attrs)
        end
      else
        instantiate_resource(:plantingActivity, response)
      end
    end

    def instantiate_resource(resource, attrs)
      Fieldview::Factory.new(resource, attrs.merge({access_token: self.access_token}))
    end
  end
end