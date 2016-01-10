require 'spec_helper'

describe MfCloud::Invoice::Client do
  describe '#initialize' do
    let(:params) do
      {
        client_id: 'client_id',
        client_secret: 'client_secret',
        access_token: 'access_token'
      }
    end

    shared_examples 'set given params' do
      it do
        config = subject.instance_variable_get(:@config)
        expect(config.client_id).to     eq params[:client_id]
        expect(config.client_secret).to eq params[:client_secret]
        expect(config.access_token).to  eq params[:access_token]
      end
    end

    context 'when pass the params' do
      subject do
        MfCloud::Invoice::Client.new(params)
      end

      it_behaves_like 'set given params'
    end

    context 'when pass the block' do
      subject do
        MfCloud::Invoice::Client.new do |client|
          client.client_id     = params[:client_id]
          client.client_secret = params[:client_secret]
          client.access_token  = params[:access_token]
        end
      end

      it_behaves_like 'set given params'
    end
  end

  describe '#office' do
    let(:client) do
      MfCloud::Invoice::Client.new(
        client_id:     'client_id',
        client_secret: 'client_secret',
        access_token:  'access_token'
      )
    end

    subject { client.office }

    it { is_expected.to be_a MfCloud::Invoice::Api::Office }
  end

  describe '#partners' do
    let(:client) do
      MfCloud::Invoice::Client.new(
        client_id:     'client_id',
        client_secret: 'client_secret',
        access_token:  'access_token'
      )
    end

    subject { client.partners }

    it { is_expected.to be_a MfCloud::Invoice::Api::Partner }
  end

  describe '#items' do
    let(:client) do
      MfCloud::Invoice::Client.new(
        client_id:     'client_id',
        client_secret: 'client_secret',
        access_token:  'access_token'
      )
    end

    subject { client.items }

    it { is_expected.to be_a MfCloud::Invoice::Api::Item }
  end

  describe '#billings' do
    let(:client) do
      MfCloud::Invoice::Client.new(
        client_id:     'client_id',
        client_secret: 'client_secret',
        access_token:  'access_token'
      )
    end

    subject { client.billings }

    it { is_expected.to be_a MfCloud::Invoice::Api::Billing }
  end

  describe '#get' do
    let(:client) do
      MfCloud::Invoice::Client.new(
        client_id:     'client_id',
        client_secret: 'client_secret',
        access_token:  'access_token'
      )
    end
    let(:dummy_params) { { hoge: 'huga'} }
    let(:dummy_response) { { "foo" => 'bar'} }

    before do
      stub_request(:get, MfCloud::Invoice::API_URL + 'v1')
        .with(query: dummy_params)
        .to_return(status: 200, body: dummy_response.to_json)
    end

    subject { client.get('', dummy_params)}

    it { is_expected.to eq dummy_response }
  end

  describe '#post' do
    let(:client) do
      MfCloud::Invoice::Client.new(
        client_id:     'client_id',
        client_secret: 'client_secret',
        access_token:  'access_token'
      )
    end
    let(:dummy_params) { { hoge: 'huga'} }
    let(:dummy_response) { { "foo" => 'bar'} }

    before do
      stub_request(:post, MfCloud::Invoice::API_URL + 'v1')
        .with(body: dummy_params)
        .to_return(status: 200, body: dummy_response.to_json)
    end

    subject { client.post('', dummy_params)}

    it { is_expected.to eq dummy_response }
  end

  describe '#put' do
    let(:client) do
      MfCloud::Invoice::Client.new(
        client_id:     'client_id',
        client_secret: 'client_secret',
        access_token:  'access_token'
      )
    end
    let(:dummy_params) { { hoge: 'huga'} }
    let(:dummy_response) { { "foo" => 'bar'} }

    before do
      stub_request(:put, MfCloud::Invoice::API_URL + 'v1')
        .with(body: dummy_params)
        .to_return(status: 200, body: dummy_response.to_json)
    end

    subject { client.put('', dummy_params)}

    it { is_expected.to eq dummy_response }
  end

  describe '#delete' do
    let(:client) do
      MfCloud::Invoice::Client.new(
        client_id:     'client_id',
        client_secret: 'client_secret',
        access_token:  'access_token'
      )
    end
    let(:dummy_params) { { hoge: 'huga'} }
    let(:dummy_response) { { "foo" => 'bar'} }

    before do
      stub_request(:delete, MfCloud::Invoice::API_URL + 'v1')
        .with(query: dummy_params)
        .to_return(status: 200, body: dummy_response.to_json)
    end

    subject { client.delete('', dummy_params)}

    it { is_expected.to eq true }
  end

  describe 'private#check_response!' do
    let(:client) do
      MfCloud::Invoice::Client.new(
        client_id:     'client_id',
        client_secret: 'client_secret',
        access_token:  'access_token'
      )
    end
    let(:dummy_response) { { "errors" => [{ 'message' => 'dummy_mesage' }] } }

    before do
      stub_request(:get, MfCloud::Invoice::API_URL + 'v1')
        .to_return(status: status, body: dummy_response.to_json)
    end

    subject { client.get('')}

    context 'when response status is 400' do
      let(:status) { 400 }

      it { expect{ subject }.to raise_error MfCloud::Invoice::InvalidRequest, dummy_response["errors"].first["message"] }
    end

    context 'when response status is 401' do
      let(:status) { 401 }

      it { expect{ subject }.to raise_error MfCloud::Invoice::InvalidAccessToken,  'アクセストークンが不正です' }
    end

    context 'when response status is 402' do
      let(:status) { 402 }

      it { expect{ subject }.to raise_error MfCloud::Invoice::PaymentRequired, dummy_response["errors"].first["message"] }
    end

    context 'when response status is 404' do
      let(:status) { 404 }

      it { expect{ subject }.to raise_error MfCloud::Invoice::ResourceNotFound, dummy_response["errors"].first["message"] }
    end

    context 'when response status is 422' do
      let(:status) { 422 }

      it { expect{ subject }.to raise_error MfCloud::Invoice::InvalidParameter, dummy_response["errors"].first["message"] }
    end

    context 'when response status is 429' do
      let(:status) { 429 }

      it { expect{ subject }.to raise_error MfCloud::Invoice::RateLimitted, dummy_response["errors"].first["message"] }
    end

    context 'when response status is 500' do
      let(:status) { 500 }

      context 'and when response has message' do
        it { expect{ subject }.to raise_error MfCloud::Invoice::InternalServerError, dummy_response["errors"].first["message"] }
      end

      context 'and when response has no message' do
        let(:dummy_response) { {} }
        it do
          expect{ subject }.to(
            raise_error(
              MfCloud::Invoice::InternalServerError,
              'サーバーがメンテナンス中かダウンしている可能性があります。しばらく待って再度お試しください。'
            )
          )
        end
      end
    end
  end
end
