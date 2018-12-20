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
      response = post_request(
        'token',
        @options.slice(:username, :password),
        content_type_header('x-www-form-urlencoded')
      )


      self.access_token = response.fetch[:jwt]
    end

  end
end
