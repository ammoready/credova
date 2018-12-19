require 'credova/version'

require 'credova/api'
require 'credova/base'
require 'credova/client'
require 'credova/error'
require 'credova/payments'
require 'credova/response'

module Credova

  class << self
    attr_accessor :sandbox
  end

  def self.sandbox?
    !!@sandbox
  end

end
