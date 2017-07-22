require 'simple_pay/signature_generator'

module SimplePay
  class Response
    STATUS_ERROR_MESSAGE =
      "Available statuses are only 'ok', 'rejected', 'error'".freeze

    include SignatureGenerator

    attr_accessor :params

    def initialize(params)
      @params = HashWithIndifferentAccess.new(params)
      @params.merge!(sp_salt: generate_salt)

      sp_can_reject = @params.delete('sp_can_reject')

      unless ['ok' ,'rejected', 'error'].include?(@params['sp_status'])
        raise ArgumentError, STATUS_ERROR_MESSAGE
      end

      if @params['sp_status'] == 'rejected' && sp_can_reject != '1'
        @params['sp_status'] = 'error'
      end
    end

    def to_json
      {
        sp_status: @params['sp_status'],
        sp_description: @params['sp_description'],
        sp_salt: @params['sp_salt'],
        sp_sig: generate_signature_for(:result)
      }.reject{ |k, v| v.blank? }.to_json
    end
  end
end
