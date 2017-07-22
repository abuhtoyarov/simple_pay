require 'spec_helper'

describe SimplePay::PaymentInterface do
  before(:each) do
    @payment_interface = SimplePay::PaymentInterface.new do
      self.sp_amount      = '102'
      self.sp_description = 'desc'
    end
  end

  it 'should return correct pay_url' do
    expect(@payment_interface.pay_url).to eq 'https://api.simplepay.pro/sp/payment?sp_amount=102&sp_description=desc&sp_outlet_id=sp_outlet_id&sp_payment_system=TEST&sp_salt=salt1234&sp_sig=5bb929070eeae614b35c0b8a992e83d1'
  end

  it 'should return correct pay_url when additional options passed' do
    url = @payment_interface.pay_url sp_amount: '102',
                                     sp_description: 'desc',
                                     sp_user_contact_email: 'foo@bar.com',
                                     sp_user_phone: '+7123456789'

    expect(url).to eq 'https://api.simplepay.pro/sp/payment?sp_amount=102&sp_description=desc&sp_outlet_id=sp_outlet_id&sp_payment_system=TEST&sp_salt=salt1234&sp_sig=edcbed5c8f8d79e6fab1de526882b23d&sp_user_contact_email=foo%40bar.com&sp_user_phone=%2B7123456789'
  end

  it 'should return correct initial_options' do
    params = {
      sp_amount: '102',
      sp_description: 'desc',
      sp_payment_system: 'TEST',
      sp_salt: 'salt1234',
      sp_outlet_id: 'sp_outlet_id'
     }
    expect(@payment_interface.initial_options).to eq(params)
  end

  it 'should return correct test_mode?' do
    expect(@payment_interface.test_mode?).to be_truthy
  end
end
