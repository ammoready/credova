require 'credova/api'

module Credova
  class Application < Base

    include Credova::API

    MINIMUM_FINANCING_AMOUNT = 300_00.freeze
    REQUIRED_CREATE_ATTRS = %i( first_name last_name date_of_birth mobile_phone email )
    REQUIRED_DELIVERY_ATTRS = %i( method address city state zip carrier tracking_number )
    ENDPOINTS = {
      check_status_by_public_id:    "applications/%s/status".freeze,
      check_status_by_phone_number: "applications/phone/%s/status".freeze,
      create:                       "applications".freeze,
      set_delivery_information:     "applications/%s/deliveryinformation".freeze,
    }

    def initialize(client)
      @client = client
    end

    def create(callback_url, options = {})
      requires!(options, REQUIRED_CREATE_ATTRS)

      endpoint = ENDPOINTS[:create]
      headers = [
        *auth_header(client.access_token),
        *content_type_header('application/json'),
      ].to_h

      post_request(endpoint, options, headers)
    end

    def check_status_by_public_id(public_id)
      endpoint = ENDPOINTS[:check_status_by_public_id] % public_id

      get_request(endpoint, auth_header(client.access_token))
    end

    def check_status_by_phone_number(phone)
      endpoint = ENDPOINTS[:check_status_by_phone_number] % phone

      get_request(endpoint, auth_header(client.access_token))
    end

    def set_delivery_information(public_id, options = {})
      requires!(options, REQUIRED_DELIVERY_ATTRS)

      endpoint = ENDPOINTS[:set_delivery_information] % public_id
      headers = [
        *auth_header(client.access_token),
        *content_type_header('application/json'),
      ].to_h

      post_request(endpoint, options, headers)
    end

  end
end
