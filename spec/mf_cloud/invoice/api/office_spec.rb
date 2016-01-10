require 'spec_helper'

describe MfCloud::Invoice::Api::Office do
  let(:client) do
    MfCloud::Invoice::Client.new(
      client_id:     'client_id',
      client_secret: 'client_secret',
      access_token:  'access_token'
    )
  end

  describe '#get' do
    let(:dummy_response) do
      {
        "name" => 'hoge',
        "zip" => '123-1234',
        "address1" => 'sample_address1',
        "address2" => 'sample address2',
        "tel" => '03-1234-1234',
        "fax" => '03-1234-1234'
      }
    end

    subject { client.office.get }

    before do
      stub_request(:get, MfCloud::Invoice::API_URL + 'v1/office')
        .to_return(status: 200, body: dummy_response.to_json)
    end

    it do
      expect(subject).to            be_a MfCloud::Invoice::Model::Office
      expect(subject.name).to       eq dummy_response["name"]
      expect(subject.zip).to        eq dummy_response["zip"]
      expect(subject.prefecture).to eq dummy_response["prefecture"]
      expect(subject.address1).to   eq dummy_response["address1"]
      expect(subject.address2).to   eq dummy_response["address2"]
      expect(subject.tel).to        eq dummy_response["tel"]
      expect(subject.fax).to        eq dummy_response["fax"]
    end
  end

  describe '#update' do
    let(:dummy_params) do
      {
        name: 'hoge',
        zip: '123-1234',
        address1: 'sample_address1',
        address2: 'sample address2',
        tel: '03-1234-1234',
        fax: '03-1234-1234'
      }
    end

    let(:dummy_response) { dummy_params }

    subject { client.office.update(dummy_params) }

    before do
      stub_request(:put, MfCloud::Invoice::API_URL + 'v1/office')
        .with(body: { office: dummy_params })
        .to_return(status: 200, body: dummy_response.to_json)
    end

    it do
      expect(subject).to            be_a MfCloud::Invoice::Model::Office
      expect(subject.name).to       eq dummy_response[:name]
      expect(subject.zip).to        eq dummy_response[:zip]
      expect(subject.prefecture).to eq dummy_response[:prefecture]
      expect(subject.address1).to   eq dummy_response[:address1]
      expect(subject.address2).to   eq dummy_response[:address2]
      expect(subject.tel).to        eq dummy_response[:tel]
      expect(subject.fax).to        eq dummy_response[:fax]
    end
  end
end

