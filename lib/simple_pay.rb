require 'simple_pay/engine'
require 'simple_pay/client'
require 'simple_pay/notification'
require 'simple_pay/payment_interface'
require 'simple_pay/response'

module SimplePay
  extend self

  def configure(&block)
    SimplePay::Client.configure &block
  end

  SimplePay::Configuration::ATTRIBUTES.map do |name|
    define_method name do
      SimplePay::Client.configuration.send(name)
    end
  end

  def pay_url(sp_amount, sp_description, extra_params = {})
    SimplePay::PaymentInterface.new do
      self.sp_amount      = sp_amount
      self.sp_description = sp_description
    end.pay_url(extra_params)
  end
end
