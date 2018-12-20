require 'net/http'

module Credova
  module API

    DEVELOPMENT_URL = 'https://staging-lending-api.credova.com'.freeze
    PRODUCTION_URL = 'https://lending-api.credova.com'.freeze
    API_VERSION = 'v2'.freeze

    USER_AGENT = "CredovaRubyGem/#{Credova::VERSION}".freeze

    def get_request(endpoint, headers = {})
      request = Net::HTTP::Get.new(request_url(endpoint))

      process_request(request, {}, headers)
    end

    def post_request(endpoint, data = {}, headers = {})
      request = Net::HTTP::Post.new(request_url(endpoint))

      process_request(request, data, headers)
    end

    private

    def process_request(request, data, headers)
      set_request_headers(request, headers)

      uri = URI(request.path)
      request.body = data.to_json

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      Credova::Response.new(response)
    end

    def set_request_headers(request, headers)
      request['User-Agent'] = USER_AGENT

      headers.each { |header, value| request[header] = value }
    end

    def auth_header(token)
      { 'Authorization' => ['Bearer', token].join(' ') }
    end

    def content_type_header(type)
      { 'Content-Type' => type }
    end

    def request_url(endpoint)
      [
        (Credova.sandbox? ? DEVELOPMENT_URL : PRODUCTION_URL),
        API_VERSION,
        endpoint,
      ].join('/')
    end

  end
end
