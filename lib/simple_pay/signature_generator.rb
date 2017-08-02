module SimplePay
  module SignatureGenerator
    KIND_ERROR_MESSAGE =
      'Available kinds are only :payment, :result or :success'.freeze

    def generate_signature_for(kind, options = {})
      unless [:success, :payment, :result].include?(kind)
        raise ArgumentError, KIND_ERROR_MESSAGE
      end
      method(SimplePay.hash_algorithm).call params_string(kind)
    end

    def params_string kind
      result = case kind
               when :payment
                 ['payment', sp_params, SimplePay.secret_key]
               when :result
                 ['result', sp_params, SimplePay.secret_key_result]
               when :success
                 ['success', sp_params, SimplePay.secret_key_result]
               end
      result.join ';'
    end

    def sp_params
      flatten_hash(@params).sort.inject([]) do |result, element|
        result << element[1] if element[0] =~ /^sp_/
        result
      end
    end

    def flatten_hash(hash, results = {}, parent_key = '')
      return results unless hash.kind_of?(Hash)

      hash.keys.each do |key|
        current_key = key
        if hash[key].kind_of?(Hash)
          results = flatten_hash(hash[key], results, current_key)
        else
          if hash[key].kind_of?(Array)
            results[current_key] = hash[key].reject(&:empty?).join("; ")
          else
            results[current_key] = hash[key]
          end
        end
      end

      results
    end

    protected

    def generate_salt(length=16)
      return 'salt1234' if Rails.env == 'test'
      chars = [*('A'..'Z'), *('a'..'z'), *(0..9)]
      (0..length).map {chars.sample}.join
    end

    def md5(data)
      Digest::MD5.hexdigest data
    end

    def sha265(data)
      Digest::SHA256.hexdigest data
    end

    def sha512(data)
      Digest::SHA512.hexdigest data
    end
  end
end
