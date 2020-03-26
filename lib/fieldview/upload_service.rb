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

      def put(path, access_token, body = {}, header = {})
        chunks      = binary_chunks(body)
        total_size  = body.size
        byte_offset = 0

        chunks.each do |chunk|
          put_response(path, access_token, byte_offset, total_size, chunk, header)
          byte_offset += chunk.size
        end
      end

      def put_response(path, access_token, byte_offset, total_size, body = {}, header = {})
        body ||= {}
        req_path = append_path_api_version(path)

        response = service.put(req_path) do |req|
          headers = default_headers({"access_token" => access_token})
          headers.merge!({"Content-Type"  => "application/octet-stream"})
          headers.merge!({"Content-Range" => "bytes #{byte_offset}-#{body.size - 1}/#{total_size}"})
          headers.merge!(header)

          req.headers.merge!(headers)
          req.body = body
        end

        check_response_status(response)

        response
      end

      private

      def binary_chunks(string)
        size = Fieldview::HttpService::MAX_BINARY_BODY_RANGE
        size = size.to_i

        Array.new(((string.length + size - 1) / size)) { |i| string.byteslice(i * size, size) }
      end
    end
  end
end