require 'simple_pay/signature_generator'

module SimplePay
  class Notification
    include SignatureGenerator

    attr_accessor :params
    attr_reader :sp_sig

    def initialize(params = {})
      @params = HashWithIndifferentAccess.new(params)
      @sp_sig = @params.delete('sp_sig')
    end

    %w(result success).map do |kind|
      define_method "valid_#{kind}_signature?" do
        sp_sig.to_s.downcase == generate_signature_for(kind.to_sym)
      end
    end

    def response(options)
      Response.new(options.merge!(sp_can_reject: @params['sp_can_reject'])).to_json
    end
  end
end
