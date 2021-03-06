module Credova
  class Response

    attr_accessor :success

    def initialize(response)
      @response = response

      case @response
      when Net::HTTPUnauthorized
        Credova::Error::NotAuthorized.new(@response.body)
      when Net::HTTPNotFound
        Credova::Error::NotFound.new(@response.body)
      when Net::HTTPNoContent
        Credova::Error::NoContent.new(@response.body)
      when Net::HTTPOK, Net::HTTPSuccess
        self.success = true
        _data = (JSON.parse(@response.body) if @response.body.present?)

        @data = case
        when _data.is_a?(Hash)
          _data.deep_symbolize_keys
        when _data.is_a?(Array)
          _data.map(&:deep_symbolize_keys)
        end
      else
        raise Credova::Error::RequestError.new(@response.body)
      end
    end

    def [](key)
      @data[key]
    end

    def body
      @data
    end

    def fetch(key)
      @data.fetch(key)
    end

    def success?
      !!success
    end

  end
end
