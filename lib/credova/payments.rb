require 'credova/api'

module Credova
  class Payments

    extend Credova::API

    ENDPOINTS = {
      lowest_payment_option:  "calculator/store/%s/amount/%s/lowestpaymentoption".freeze,
      lender_payment_options: "calculator/lender/%s/amount/%s".freeze,
      store_payment_options:  "calculator/store/%s/amount/%s".freeze,
    }

    def self.lowest_payment_option(store_code, amount_to_finance)
      endpoint = ENDPOINTS[:lowest_payment_option] % [store_code, amount_to_finance]

      post_request(endpoint)
    end

    def self.lender_payment_options(lender_code, amount_to_finance)
      endpoint = ENDPOINTS[:lender_payment_options] % [lender_code, amount_to_finance]

      post_request(endpoint)
    end

    def self.store_payment_options(store_code, amount_to_finance)
      endpoint = ENDPOINTS[:store_payment_options] % [store_code, amount_to_finance]

      post_request(endpoint)
    end

  end
end
