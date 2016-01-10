require 'spec_helper'

describe MfCloud::Invoice do
  it 'has a version number' do
    expect(MfCloud::Invoice::VERSION).not_to be nil
  end

  it 'set the mf_cloud invoice api url' do
    expect(MfCloud::Invoice::API_URL).to eq 'https://invoice.moneyforward.com/api/'
  end
end
