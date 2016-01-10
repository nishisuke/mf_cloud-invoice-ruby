require 'spec_helper'

describe MfCloud::Invoice::Api::Item do
  let(:client) do
    MfCloud::Invoice::Client.new(
      client_id:     'client_id',
      client_secret: 'client_secret',
      access_token:  'access_token'
    )
  end

  describe '#all' do
    let(:dummy_response) do
      {
        "meta" => {
          "total_count"  => 2,
          "total_pages"  => 1,
          "current_page" => 1,
          "per_page"     => 10,
        },
        "items" => [
          {
            "id"         => 'ABCDEFGHIJKLMN',
            "code"       => "dummy_code",
            "name"       => "dummy_name",
            "detail"     => "dummy_detail",
            "unit_price" => 100,
            "quantity"   => 1,
            "price"      => 100,
            "excise"     => true,
            "created_at"  => "2016-01-01T00:00:00+0900",
            "updated_at"  => "2016-01-01T00:00:00+0900"
          },
          {
            "id"         => 'ABCDEFGHIJKLMN',
            "code"       => "dummy_code",
            "name"       => "dummy_name",
            "detail"     => "dummy_detail",
            "unit_price" => 100,
            "quantity"   => 1,
            "price"      => 100,
            "excise"     => true,
            "created_at"  => "2016-01-01 00:00:00",
            "updated_at"  => "2016-01-01 00:00:00"
          }
        ]
      }
    end

    subject { client.items.all }

    before do
      stub_request(:get, MfCloud::Invoice::API_URL + "v1/items")
        .to_return(status: 200, body: dummy_response.to_json )
    end

    it do
      expect(subject).to be_a MfCloud::Invoice::Collection::ItemCollection
      expect(subject.count).to eq 2

      item = subject.first
      expect(item).to            be_a MfCloud::Invoice::Model::Item
      expect(item.id).to         eq dummy_response["items"][0]["id"]
      expect(item.code).to       eq dummy_response["items"][0]["code"]
      expect(item.name).to       eq dummy_response["items"][0]["name"]
      expect(item.detail).to     eq dummy_response["items"][0]["detail"]
      expect(item.unit_price).to eq dummy_response["items"][0]["unit_price"]
      expect(item.quantity).to   eq dummy_response["items"][0]["quantity"]
      expect(item.price).to      eq dummy_response["items"][0]["price"]
      expect(item.excise).to     eq dummy_response["items"][0]["excise"]
      expect(item.created_at).to eq dummy_response["items"][0]["created_at"]
      expect(item.updated_at).to eq dummy_response["items"][0]["updated_at"]
    end
  end

  describe '#get' do
    let(:dummy_id) { 'ABCDEFGHIJKLMN' }
    let(:dummy_response) do
      {
        "id"         => dummy_id,
        "code"       => "dummy_code",
        "name"       => "dummy_name",
        "detail"     => "dummy_detail",
        "unit_price" => 100,
        "quantity"   => 1,
        "price"      => 100,
        "excise"     => true,
        "created_at"  => "2016-01-01 00:00:00",
        "updated_at"  => "2016-01-01 00:00:00"
      }
    end

    subject { client.items.get(dummy_id) }

    before do
      stub_request(:get, MfCloud::Invoice::API_URL + "v1/items/#{dummy_id}")
        .to_return(status: 200, body: dummy_response.to_json)
    end

    it do
      expect(subject).to            be_a MfCloud::Invoice::Model::Item
      expect(subject.id).to         eq dummy_response["id"]
      expect(subject.code).to       eq dummy_response["code"]
      expect(subject.name).to       eq dummy_response["name"]
      expect(subject.detail).to     eq dummy_response["detail"]
      expect(subject.unit_price).to eq dummy_response["unit_price"]
      expect(subject.quantity).to   eq dummy_response["quantity"]
      expect(subject.price).to      eq dummy_response["price"]
      expect(subject.excise).to     eq dummy_response["excise"]
      expect(subject.created_at).to eq dummy_response["created_at"]
      expect(subject.updated_at).to eq dummy_response["updated_at"]
    end
  end

  describe '#create' do
    let(:dummy_params) do
      {
        "code"       => "dummy_code",
        "name"       => "dummy_name",
        "detail"     => "dummy_detail",
        "unit_price" => 100,
        "quantity"   => 1,
        "price"      => 100,
        "excise"     => true,
      }
    end

    let(:dummy_response) do
      {
        "id"         => 'ABCDEFGHIJKLMN',
        "code"       => "dummy_code",
        "name"       => "dummy_name",
        "detail"     => "dummy_detail",
        "unit_price" => 100,
        "quantity"   => 1,
        "price"      => 100,
        "excise"     => true,
        "created_at"  => "2016-01-01 00:00:00",
        "updated_at"  => "2016-01-01 00:00:00"
      }
    end

    subject { client.items.create(dummy_params) }

    before do
      stub_request(:post, MfCloud::Invoice::API_URL + "v1/items")
        .with(body: { item: dummy_params })
        .to_return(status: 200, body: dummy_response.to_json)
    end

    it do
      expect(subject).to            be_a MfCloud::Invoice::Model::Item
      expect(subject.id).to         eq dummy_response["id"]
      expect(subject.code).to       eq dummy_response["code"]
      expect(subject.name).to       eq dummy_response["name"]
      expect(subject.detail).to     eq dummy_response["detail"]
      expect(subject.unit_price).to eq dummy_response["unit_price"]
      expect(subject.quantity).to   eq dummy_response["quantity"]
      expect(subject.price).to      eq dummy_response["price"]
      expect(subject.excise).to     eq dummy_response["excise"]
      expect(subject.created_at).to eq dummy_response["created_at"]
      expect(subject.updated_at).to eq dummy_response["updated_at"]
    end
  end

  describe '#update' do
    let(:dummy_id) { 'ABCDEFGHIJKLMN' }

    let(:dummy_params) do
      {
        "code"       => "dummy_code",
        "name"       => "dummy_name",
        "detail"     => "dummy_detail",
        "unit_price" => 100,
        "quantity"   => 1,
        "price"      => 100,
        "excise"     => true
      }
    end

    let(:dummy_response) do
      {
        "id"         => dummy_id,
        "code"       => "dummy_code",
        "name"       => "dummy_name",
        "detail"     => "dummy_detail",
        "unit_price" => 100,
        "quantity"   => 1,
        "price"      => 100,
        "excise"     => true,
        "created_at"  => "2016-01-01 00:00:00",
        "updated_at"  => "2016-01-01 00:00:00"
      }
    end

    subject { client.items.update(dummy_id, dummy_params) }

    before do
      stub_request(:put, MfCloud::Invoice::API_URL + "v1/items/#{dummy_id}")
        .with(body: { item: dummy_params })
        .to_return(status: 200, body: dummy_response.to_json)
    end

    it do
      expect(subject).to            be_a MfCloud::Invoice::Model::Item
      expect(subject.id).to         eq dummy_response["id"]
      expect(subject.code).to       eq dummy_response["code"]
      expect(subject.name).to       eq dummy_response["name"]
      expect(subject.detail).to     eq dummy_response["detail"]
      expect(subject.unit_price).to eq dummy_response["unit_price"]
      expect(subject.quantity).to   eq dummy_response["quantity"]
      expect(subject.price).to      eq dummy_response["price"]
      expect(subject.excise).to     eq dummy_response["excise"]
      expect(subject.created_at).to eq dummy_response["created_at"]
      expect(subject.updated_at).to eq dummy_response["updated_at"]
    end
  end

  describe '#delete' do
    let(:dummy_id) { 'ABCDEFGHIJKLMN' }

    subject { client.items.delete(dummy_id) }

    before do
      stub_request(:delete, MfCloud::Invoice::API_URL + "v1/items/#{dummy_id}")
        .to_return(status: 204)
    end

    it { is_expected.to be true }
  end
end
