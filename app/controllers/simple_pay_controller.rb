class SimplePayController < ActionController::Base
  if respond_to?(:before_action)
    before_action :create_notification
  else
    before_filter :create_notification
  end

  def result
    if @notification.valid_result_signature?
      instance_exec @notification, &SimplePay.result_callback
    else
      instance_exec @notification, &SimplePay.fail_callback
    end
  end

  def success
    if @notification.valid_success_signature?
      instance_exec @notification, &SimplePay.success_callback
    else
      instance_exec @notification, &SimplePay.fail_callback
    end
  end

  def fail
    instance_exec @notification, &SimplePay.fail_callback
  end

  private

  def create_notification
    if request.get?
      @notification = SimplePay::Notification.new request.query_parameters
    elsif request.post?
      # WTF SimplePay sends a POST request with query parameters if success.
      req_prm = request.request_parameters.presence || request.query_parameters
      @notification = SimplePay::Notification.new req_prm
    end
  end
end
