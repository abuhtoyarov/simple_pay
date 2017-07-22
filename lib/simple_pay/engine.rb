require 'simple_pay/action_view_extension'

module SimplePay
  class Engine < ::Rails::Engine
    initializer 'simple_pay.action_view_extension' do
      ActionView::Base.send :include, SimplePay::ActionViewExtension
    end
  end
end
