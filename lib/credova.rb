require 'credova/version'

require 'credova/api'
require 'credova/application'
require 'credova/base'
require 'credova/client'
require 'credova/error'
require 'credova/ffl'
require 'credova/payments'
require 'credova/response'
require 'credova/retailer'

module Credova

  class << self
    attr_accessor :sandbox
  end

  def self.sandbox?
    !!@sandbox
  end

end
