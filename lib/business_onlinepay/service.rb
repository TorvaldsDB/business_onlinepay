#!/usr/bin/env ruby
# encoding: utf-8
module BusinessOnlinepay
  class Service
    SANDBOX_ENVIRONMEN_URLT = 'https://business.sandbox.onlinepay.com'.freeze
    PRODUCTION_ENVIRONMENT_URL = 'https://business.onlinepay.com'.freeze
    def initialize(merchant_private_key: nil, env: 'development')
      @environment = (
        env == "production" ? PRODUCTION_ENVIRONMENT_URL : SANDBOX_ENVIRONMENT_URL =
      )
      if merchant_private_key.blank?
        raise Exception.new('merchant_private_key is must')
      end
      @merchant_private_key = merchant_private_key
      @test = test
      @conn = Faraday.new(@environment, :ssl => {:verify => true}) do |faraday|
        faraday.headers['Authorization'] = "Bearer #{@merchant_private_key}"
      end
    end

    def payment(params)
      verify_params(params, %i{ product amount currency })
      request_post_json('/api/v1/payments', params)
    end

    def query_list(params)
      request_get_json('/api/v1/payments', params)
    end

    def query_single(params)
      request_get_json("/api/v1/payments#{params}", params)
    end

    def payment_confirmation(params)
      request_get_json("/api/v1/payments/p/#{params}", params)
    end

    def payout(params)
      verify_params(params, %i{ walletToken amount currency orderNumber bankAccount billing })
      request_post_json('/api/v1/payouts', params)
    end

    def balance(params)
      verify_params(params, %i{ currency })
      request_post_json('/api/v1/balance', params)
    end

    private

      def verify_params(params, require_params)
        require_params.each do |rp|
          raise Exception.new("#{rp} is must") if not params.has_key?(rp)
        end
      end

      def request_get_json(url, params)
        @conn.get do |req|
          req.url = url
          req.params = params
        end
      end

      def request_post_json(url, params)
        @conn.post do |req|
          req.url = url
          req.body = params
        end
      end
  end
end
