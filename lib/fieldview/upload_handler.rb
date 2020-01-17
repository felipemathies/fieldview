module Fieldview
  class UploadHandler

    attr_accessor :data, :email

    def initialize(data, email)
 			self.data  = data
      self.email = email
 		end

    def heatmap_upload_id_args
      {
        headers: upload_id_default_headers,
        body:    heatmap_upload_id_body
      }
    end

    private

    def heatmap_upload_id_body
      upload_id_default_body.merge!({ contentType: "image/vnd.climate.rgb.geotiff" })
    end

    def upload_id_default_body
      {
        md5:    Digest::MD5.hexdigest(self.data),
        length: self.data.size
      }
    end

    def upload_id_default_headers
      headers = {}
      headers['X-Recipient-Email'] = self.email
      
      headers
    end
  end
end