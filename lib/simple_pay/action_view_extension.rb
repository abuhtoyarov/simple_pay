module SimplePay
  module ActionViewExtension
    def pay_url(phrase, sp_amount, sp_description, options = {}, &block)
      sp_amount, sp_description  = sp_amount.to_s, sp_description.to_s
      extra_params  = options.except :custom, :html
      html_params = options[:html] ||= {}
      url = SimplePay.pay_url sp_amount, sp_description, extra_params
      if block_given?
        link_to phrase, url, html_params, &block
      else
        link_to phrase, url, html_params
      end
    end
  end
end
