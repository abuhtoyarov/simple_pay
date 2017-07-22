SimplePay.configure do |config|
  config.sp_outlet_id = ENV['SP_OUTLET_ID']
  config.secret_key = ENV['SECRET_KEY']
  config.secret_key_result = ENV['SECRET_KEY_RESULT']
  config.mode = :test # or :production
  config.http_method = :post # or :get
  config.hash_algorithm = :md5 # or :sha256, :sha512

  config.result_callback = ->(notification) do
    render text: notification.response({sp_status: 'ok'})
  end

  # Define success or failure callbacks here like:

  # config.success_callback = ->(notification) { render text: 'success' }
  # config.fail_callback = ->(notification) { redirect_to root_path }
end
