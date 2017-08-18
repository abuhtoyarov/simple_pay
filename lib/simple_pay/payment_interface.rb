require 'simple_pay/signature_generator'

module SimplePay
  class PaymentInterface
    include SignatureGenerator

    BASE_URL = 'https://api.simplepay.pro/sp/payment'.freeze

    attr_accessor :sp_amount, :sp_description

    def initialize(&block)
      instance_eval &block if block_given?
    end

    def test_mode?
      SimplePay.mode == :test
    end

    def pay_url(extra_params = {})
      extra_params = extra_params.slice :sp_order_id, :sp_payment_system, :sp_lifetime,
                                        :sp_user_name, :sp_user_phone, :sp_user_contact_email,
                                        :sp_user_ip, :sp_recurring_start, :sp_success_url,
                                        :sp_failure_url, :sp_result_url, :sp_ps_account, :sp_partner_id,

      @params = HashWithIndifferentAccess.new(initial_options.merge(extra_params))

      signature = generate_signature_for(:payment)

      result_params = @params.merge(sp_sig: signature)


      BASE_URL.dup << '?' << result_params.to_query
    end

    def initial_options
      result = {
        sp_outlet_id: SimplePay.sp_outlet_id,
        sp_amount: @sp_amount,
        sp_description: @sp_description,
        sp_salt: generate_salt
      }
      result.merge!(sp_payment_system: 'TEST') if test_mode?
      result
    end
  end
end
