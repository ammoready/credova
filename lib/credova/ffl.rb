require 'credova/api'

module Credova
  class FFL < Base

    include Credova::API

    REQUIRED_CREATE_ATTRS = %i( license_number expiration address_one city state zip )
    ENDPOINTS = {
      create:          "federallicense".freeze,
      upload_document: "federallicense/%s/uploadfile".freeze,
    }

    def initialize(client)
      @client = client
    end

    def create(options = {})
      requires!(options, REQUIRED_CREATE_ATTRS)

      endpoint = ENDPOINTS[:create]
      data = format_data_for_create(options)
      headers  = [
        *auth_header(@client.access_token),
        *content_type_header('application/json'),
      ].to_h

      post_request(endpoint, data, headers)
    end

    def upload_document(ffl_public_id, ffl_document_url)
      endpoint = ENDPOINTS[:upload_document] % ffl_public_id
      data     = { form_data: ['file=@', ffl_document_url, '; type=application/', extract_file_type(ffl_document_url)].join }
      headers  = [
        *auth_header(@client.access_token),
        *content_type_header('multipart/form-data'),
      ].to_h

      post_request(endpoint, data, headers)
    end

    private

    def extract_file_type(ffl_document_url)
      metadata_raw  = Net::HTTP.get(URI.parse("#{ffl_document_url}/metadata"))
      metadata_json = JSON.parse(metadata_raw)
      file_name     = metadata_json['filename']

      file_name[(file_name.rindex('.') + 1)..-1]
    end

    def format_data_for_create(data)
      {
        licenseNumber: data[:license_number],
        expiration:    data[:expiration].strftime('%Y/%m/%d'),
        address:       data[:address_one],
        address2:      data[:address_two],
        city:          data[:city],
        state:         data[:state],
        zip:           data[:zip],
      }
    end

  end
end
