require 'spec_helper'

describe SimplePay::Response do

  it 'should raise error when wrong sp_status is set' do
    expect {
      SimplePay::Response.new(sp_status: 'ok123')
    }.to raise_error(ArgumentError, SimplePay::Response::STATUS_ERROR_MESSAGE)
  end

  it 'should return ok status' do
    resp = SimplePay::Response.new({sp_status: 'ok'})
    expect(resp.params['sp_status']).to eq('ok')
  end

  it 'should return error status' do
    resp = SimplePay::Response.new({sp_status: 'error'})
    expect(resp.params['sp_status']).to eq('error')
  end

  it 'should return rejected status if sp_can_reject=1' do
    resp = SimplePay::Response.new({sp_status: 'rejected', sp_can_reject: '1'})
    expect(resp.params['sp_status']).to eq('rejected')
  end

  it 'should return error status unless sp_can_reject' do
    resp = SimplePay::Response.new({sp_status: 'rejected'})
    expect(resp.params['sp_status']).to eq('error')
  end
end
