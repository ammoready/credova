require 'credova/api'

module Credova
  class FFL < Base

    include Credova::API

    CREATE_ATTRS = {
      permitted: %i( license_number expiration address address_2 city state zip ).freeze,
      required:  %i( license_number expiration address city state zip ).freeze,
    }

    ENDPOINTS = {
      create:          "federallicense".freeze,
      upload_document: "federallicense/%s/uploadfile".freeze,
    }

    def initialize(client)
      @client = client
    end

    def create(ffl_data)
      requires!(options, *REQUIRED_CREATE_ATTRS)

      ffl_data[:expiration] = ffl_data[:expiration].strftime('%Y/%m/%d')
      endpoint = ENDPOINTS[:create]
      headers  = [
        *auth_header(@client.access_token),
        *content_type_header('application/json'),
      ].to_h

      standardize_body_data!(ffl_data, CREATE_ATTRS[:permitted])

      post_request(endpoint, ffl_data, headers)
    end

    def upload_document(ffl_public_id, ffl_document_url)
      endpoint = ENDPOINTS[:upload_document] % ffl_public_id
      data     = { form_data: ['file=@', ffl_document_url, '; type=application/', extract_file_extension(ffl_document_url)].join }
      headers  = [
        *auth_header(@client.access_token),
        *content_type_header('multipart/form-data'),
      ].to_h

      post_request(endpoint, data, headers)
    end

  end
end
