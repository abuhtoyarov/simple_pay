Rails.application.routes.draw do
  if SimplePay::Client.configuration
    scope :simple_pay do
      %w(result success fail).map do |route|
        match route,
              controller: :simple_pay,
              action: route,
              via: SimplePay.http_method,
              constraints: { subdomain: /payment/ }
      end
    end
  end
end
