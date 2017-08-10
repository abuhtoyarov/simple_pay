require 'spec_helper'

describe SimplePay::Notification do
  before(:each) do
    SimplePay.configure do |config|
    end
  end

  it 'should return correct valid_result_signature?' do
    params = { 'sp_order_id' => '123321',
               'sp_payment_id' => 'value1',
               'sp_amount' => '100',
               'sp_sig' => '9c94c2bfb35ff98fe53e27e25a4f79af',
                'sp_salt' => 'kcdksmcksmdckdmckd'}
    notification = SimplePay::Notification.new params
    expect(notification.valid_result_signature?).to be_truthy
  end

  it 'should return correct valid_success_signature?' do
    params = { 'sp_order_id' => '123321',
               'sp_payment_id' => 'value1',
               'sp_amount' => '100',
               'sp_sig' => 'e96f1e06df0fc73442cacde659ae101f',
                'sp_salt' => 'kcdksmcksmdckdmckd'}

    notification = SimplePay::Notification.new params
    expect(notification.valid_success_signature?).to be_truthy
  end

  it 'should return correct success response' do
    notification = SimplePay::Notification.new
    params = {'response' => {
      'sp_status' => 'ok',
      'sp_salt' => 'salt1234',
      'sp_sig' => '5695d225fcfb14e1f408beaffde1e250'
    }}.to_json

    expect(notification.response({sp_status: 'ok'})).to eq(params)
  end

  it 'should return correct error response' do
    notification = SimplePay::Notification.new
    params = {'response' => {
      'sp_status' => 'error',
      'sp_salt' => 'salt1234',
      'sp_sig' => 'dff463b8b22e5b784d26189a4133ab74'
    }}.to_json

    expect(notification.response({sp_status: 'error'})).to eq(params)
  end

  it 'should return correct rejected response' do
    notification = SimplePay::Notification.new({sp_can_reject: '1'})
    params = {'response' => {
      'sp_status' => 'rejected',
      'sp_salt' => 'salt1234',
      'sp_sig' => 'ebcaeafe110e727fae4ae67c61d01f17'
    }}.to_json

    expect(notification.response({sp_status: 'rejected'})).to eq(params)
  end

  context 'signature generator' do
    it 'should raise error in case of wrong kind of argument' do
      expect {
        notification = SimplePay::Notification.new
        notification.generate_signature_for :bullshit
      }.to raise_error(ArgumentError,
                       SimplePay::SignatureGenerator::KIND_ERROR_MESSAGE)
    end
  end
end
