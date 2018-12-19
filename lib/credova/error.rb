module Credova
  class Error < StandardError

    class NotAuthorized < Credova::Error; end
    class NotFound < Credova::Error; end
    class RequestError < Credova::Error; end
    class TimeoutError < Credova::Error; end

  end
end
