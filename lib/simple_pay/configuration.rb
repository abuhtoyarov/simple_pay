module SimplePay
  class Configuration
    ATTRIBUTES = [
      :sp_outlet_id, :secret_key, :secret_key_result, :mode, :http_method,
      :success_callback, :fail_callback, :result_callback, :hash_algorithm
    ]
    HASH_ALGORITHMS = [:md5, :sha256, :sha512]

    attr_accessor *ATTRIBUTES

    def initialize
      self.sp_outlet_id = 'sp_outlet_id'
      self.secret_key   = 'secret_key'
      self.secret_key_result  = 'secret_key'
      self.mode             = :test
      self.http_method      = :get
      self.hash_algorithm   = :md5
      self.success_callback = -> (notification) { render text: 'success' }
      self.fail_callback    = -> (notification) { render text: 'fail' }
      self.result_callback  = -> (notification) do
        render text: response({sp_status: 'ok'})
      end
    end

    def correct_mode?
      [:test, :production].include?(mode)
    end

    def correct_http_method?
      [:get, :post].include?(http_method)
    end

    def correct_hash_algorithm?
      HASH_ALGORITHMS.include?(hash_algorithm)
    end
  end
end
