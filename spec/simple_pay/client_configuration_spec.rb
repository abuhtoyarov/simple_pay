require 'spec_helper'

describe SimplePay::Client do
  before(:each) do
    SimplePay.configure do |config|
      config.sp_outlet_id = '123456789'
      config.secret_key = 'mciodscdcdscds'
      config.mode = :production
      config.http_method = :get
      config.hash_algorithm = :md5
    end
  end

  it 'should set configuration information correctly' do
    expect(SimplePay.sp_outlet_id).to eq '123456789'
    expect(SimplePay.secret_key).to eq 'mciodscdcdscds'
    expect(SimplePay.mode).to eq :production
  end

  it 'should set default values' do
    SimplePay.configure do; end

    expect(SimplePay.sp_outlet_id).to eq 'sp_outlet_id'
    expect(SimplePay.secret_key).to eq 'secret_key'
    expect(SimplePay.mode).to eq :test
    expect(SimplePay.http_method).to eq :get
    expect(SimplePay.hash_algorithm).to eq :md5
    expect(SimplePay.success_callback).to be_instance_of(Proc)
    expect(SimplePay.fail_callback).to be_instance_of(Proc)
  end

  it 'should set success_callback' do
    SimplePay.configure do |config|
      config.success_callback = -> { 2 + 5 }
    end
    expect(SimplePay.success_callback.call).to eq(7)
  end

  it 'should raise error when wrong mode is set' do
    expect {
      SimplePay.configure do |config|
        config.mode = :bullshit
      end
    }.to raise_error(SimplePay::ConfigurationError,
                     SimplePay::ConfigurationError::ENV_MESSAGE)
  end

  it 'should raise error when wrong http_method is set' do
    expect {
      SimplePay.configure do |config|
        config.http_method = :bullshit
      end
    }.to raise_error(SimplePay::ConfigurationError,
                     SimplePay::ConfigurationError::HTTP_METHOD_MESSAGE)
  end

  it 'should raise error when wrong hash_algorithms is set' do
    expect {
      SimplePay.configure do |config|
        config.hash_algorithm = :bullshit
      end
    }.to raise_error(SimplePay::ConfigurationError,
                     SimplePay::ConfigurationError::HASH_ALGORITHM_MESSAGE)
  end
end
