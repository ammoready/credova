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
      find:            "federallicense/licensenumber/%s".freeze,
      upload_document: "federallicense/%s/uploadfile".freeze,
    }

    def initialize(client)
      @client = client
    end

    def create(ffl_data)
      requires!(ffl_data, *CREATE_ATTRS[:required])

      ffl_data[:expiration] = ffl_data[:expiration].strftime('%Y/%m/%d')
      endpoint = ENDPOINTS[:create]
      headers  = [
        *auth_header(@client.access_token),
        *content_type_header('application/json'),
      ].to_h

      ffl_data = standardize_body_data(ffl_data, CREATE_ATTRS[:permitted])

      post_request(endpoint, ffl_data, headers)
    end

    def find(license_number)
      endpoint = ENDPOINTS[:find] % license_number

      get_request(endpoint, auth_header(@client.access_token))
    end

    def upload_document(ffl_public_id, ffl_file_data)
      requires!(ffl_file_data, *FILE_UPLOAD_ATTRS[:required])

      endpoint = ENDPOINTS[:upload_document] % ffl_public_id

      post_file_request(endpoint, ffl_file_data, auth_header(@client.access_token))
    end

  end
end
