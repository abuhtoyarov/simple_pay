## The SimplePay gem

## Installation

Add to your `Gemfile`:

    gem "simple_pay"

## Usage

Run `rails g simple_pay:install`, get an initializer with the following code:

    SimplePay.configure do |config|
      config.sp_outlet_id = ENV['SP_OUTLET_ID']
      config.secret_key = ENV['SECRET_KEY']
      config.mode = :test # or :production
      config.http_method = :get # or :post
      config.hash_algorithm = :md5 # or :sha256, :sha512
    end


    To define custom success/fail callbacks you can also use the initializer:

        SimplePay.configure do |config|
          ...
          config.success_callback = ->(notification) { render text: 'success' }
          config.fail_callback    = ->(notification) { redirect_to root_path }
          config.result_callback  = ->(notification) { render text: notification.success }
        end

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
