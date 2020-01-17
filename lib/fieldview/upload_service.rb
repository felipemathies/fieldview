module Fieldview
  class UploadService < Fieldview::HttpService

    class << self
      def post(path, access_token, body = {}, header = {})
        response = post_response(path, access_token, body, header)

        response.status.to_i == 201 ? response.body.gsub(/[\"]/,"") : nil
      end

      def post_response(path, access_token, body = {}, header = {})
        body ||= {}
        req_path = append_path_api_version(path)

        response = service.post(req_path) do |req|
          headers = default_headers({"access_token" => access_token})
          headers.merge!({"Content-Type" => "application/json"})
          headers.merge!(header)

          req.headers.merge!(headers)
          req.body = body.to_json
        end

        check_response_status(response)

        response
      end
    end
  end
end