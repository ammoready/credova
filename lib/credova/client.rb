require 'credova/api'

module Credova
  class Client < Base

    include Credova::API

    attr_accessor :access_token

    def initialize(options = {})
      requires!(options, :username, :password)
      @options = options

      authenticate!
    end

    private

    def authenticate!
      header = { 'Content-Type' => 'application/x-www-form-urlencoded' }

      response = post_request(:token, @options.slice(:username, :password), header)

      self.access_token = response.fetch[:jwt]
    end

  end
end
