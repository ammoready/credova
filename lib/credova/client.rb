require 'credova/api'
require 'credova/application'
require 'credova/ffl'
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

    def ffl
      @ffl ||= Credova::FFL.new(self)
    end

    def retailer
      @retailer ||= Credova::Retailer.new(self)
    end

    private

    def authenticate!
      response = post_request(
        'token',
        ['username=', @options[:username], '&password=', @options[:password]].join,
        content_type_header('application/x-www-form-urlencoded')
      )

      self.access_token = response.fetch[:jwt]
    end

  end
end
