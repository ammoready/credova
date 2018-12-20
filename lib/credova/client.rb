require 'credova/api'
require 'credova/application'
require 'credova/retailer'

module Credova
  class Client < Base

    include Credova::API

    attr_accessor :access_token

    def initialize(options = {})
      requires!(options, :username, :password)
      @options = options

      authenticate!
    end

    def application
      @application ||= Credova::Application.new(self)
    end

    def retailer
      @retailer ||= Credova::Retailer.new(self)
    end

    private

    def authenticate!
      response = post_request(
        'token',
        @options.slice(:username, :password),
        content_type_header('x-www-form-urlencoded')
      )


      self.access_token = response.fetch[:jwt]
    end

  end
end
