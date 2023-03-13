require 'credova/api'

module Credova
  class Application < Base

    include Credova::API

    MINIMUM_FINANCING_AMOUNT = 300_00.freeze
    MAXIMUM_FINANCING_AMOUNT = 10_000_00.freeze

    CREATE_ATTRS = {
      permitted: %i( public_id store_code first_name middle_initial last_name date_of_birth mobile_phone email address products redirect_url reference_number ).freeze,
      required:  %i( store_code first_name last_name mobile_phone email ).freeze
    }

    SET_DELIVERY_INFORMATION_ATTRS = {
      permitted: %i( federal_license_number method address address_2 city state zip carrier tracking_number ).freeze,
      required:  %i( method address city state zip carrier tracking_number ).freeze
    }

    ENDPOINTS = {
      check_status_by_public_id:    "applications/%s/status".freeze,
      check_status_by_phone_number: "applications/phone/%s/status".freeze,
      create:                       "applications".freeze,
      set_delivery_information:     "applications/%s/deliveryinformation".freeze,
      request_return:               "applications/%s/requestreturn".freeze,
      upload_invoice:               "applications/%s/uploadinvoice".freeze,
    }

    def initialize(client)
      @client = client
    end

    def create(application_data, callback_url = nil)
      requires!(application_data, *CREATE_ATTRS[:required])

      endpoint = ENDPOINTS[:create]
      headers = [
        *auth_header(@client.access_token),
        *content_type_header('application/json'),
      ].to_h

      headers['Callback-Url'] = callback_url if callback_url.present?

      application_data = standardize_body_data(application_data, CREATE_ATTRS[:permitted])

      post_request(endpoint, application_data, headers)
    end

    def check_status_by_public_id(public_id)
      endpoint = ENDPOINTS[:check_status_by_public_id] % public_id

      get_request(endpoint, auth_header(@client.access_token))
    end

    def check_status_by_phone_number(phone)
      endpoint = ENDPOINTS[:check_status_by_phone_number] % phone

      get_request(endpoint, auth_header(@client.access_token))
    end

    def set_delivery_information(public_id, delivery_data)
      requires!(delivery_data, *SET_DELIVERY_INFORMATION_ATTRS[:required])

      endpoint = ENDPOINTS[:set_delivery_information] % public_id
      headers = [
        *auth_header(@client.access_token),
        *content_type_header('application/json'),
      ].to_h

      delivery_data = standardize_body_data(delivery_data, SET_DELIVERY_INFORMATION_ATTRS[:permitted])

      post_request(endpoint, delivery_data, headers)
    end

    def request_return(public_id)
      endpoint = ENDPOINTS[:request_return] % public_id

      post_request(endpoint, {}, auth_header(@client.access_token))
    end

    def upload_invoice(public_id, invoice_file_data)
      requires!(invoice_file_data, *FILE_UPLOAD_ATTRS[:required])

      endpoint = ENDPOINTS[:upload_invoice] % public_id

      post_file_request(endpoint, invoice_file_data, auth_header(@client.access_token))
    end

  end
end
