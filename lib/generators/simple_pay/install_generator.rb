require 'rails/generators'

module SimplePay
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def create_initializer_file
      template 'simple_pay.rb',
               File.join('config', 'initializers', 'simple_pay.rb')
    end
  end
end
