require 'credova/api'

module Credova
  class Retailer

    include Credova::API

    ENDPOINTS = {
      lenders: "lenders".freeze,
      stores:  "stores".freeze,
    }

    def initialize(client)
      @client = client
    end

    def lenders
      endpoint = ENDPOINTS[:lenders]

      get_request(endpoint, auth_header(@client.access_token))
    end

    def stores
      endpoint = ENDPOINTS[:stores]

      get_request(endpoint, auth_header(@client.access_token))
    end

  end
end
