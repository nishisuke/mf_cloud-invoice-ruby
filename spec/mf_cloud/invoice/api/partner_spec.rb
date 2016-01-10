require 'spec_helper'

describe MfCloud::Invoice::Api::Partner do
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
        "partners" => [
          {
            "id"          => 'ABCDEFGHIJKLMN',
            "code"        => "dummy_code",
            "name"        => "dummy_name",
            "name_kana"   => "ダミーネーム",
            "name_suffix" => "様",
            "memo"        => "dummy_memo",
            "created_at"  => "2016-01-01T00:00:00+0900",
            "updated_at"  => "2016-01-01T00:00:00+0900",
            "departments" => [
              {
                "id"           => "OPQRSTUVWXYZ",
                "name"         => "dummy_name",
                "zip"          => "123-1234",
                "tel"          => "03-1234-1234",
                "prefecture"   => "東京都",
                "address1"     => "dummy address1",
                "address2"     => "dummy address2",
                "person_title" => "dummy person title",
                "person_name"  => "dummy person name",
                "email"        => "dummy email",
                "cc_emails"    => "dummy cc_emails",
                "created_at"   => "2016-01-01T00:00:00+0900",
                "updated_at"   => "2016-01-01T00:00:00+0900"
              }
            ]
          },
          {
            "id"          => 'ABCDEFGHIJKLMN',
            "code"        => "dummy_code",
            "name"        => "dummy_name",
            "name_kana"   => "ダミーネーム",
            "name_suffix" => "様",
            "memo"        => "dummy_memo",
            "created_at"  => "2016-01-01T00:00:00+0900",
            "updated_at"  => "2016-01-01T00:00:00+0900",
            "departments" => [
              {
                "id"           => "OPQRSTUVWXYZ",
                "name"         => "dummy_name",
                "zip"          => "123-1234",
                "tel"          => "03-1234-1234",
                "prefecture"   => "東京都",
                "address1"     => "dummy address1",
                "address2"     => "dummy address2",
                "person_title" => "dummy person title",
                "person_name"  => "dummy person name",
                "email"        => "dummy email",
                "cc_emails"    => "dummy cc_emails",
                "created_at"   => "2016-01-01T00:00:00+0900",
                "updated_at"   => "2016-01-01T00:00:00+0900"
              }
            ]
          }
        ]
      }
    end

    subject { client.partners.all }

    before do
      stub_request(:get, MfCloud::Invoice::API_URL + "v1/partners")
        .to_return(status: 200, body: dummy_response.to_json )
    end

    it do
      expect(subject).to be_a MfCloud::Invoice::Collection::PartnerCollection
      expect(subject.count).to eq 2

      partner = subject.first
      expect(partner.code).to        eq dummy_response["partners"][0]["code"]
      expect(partner.name).to        eq dummy_response["partners"][0]["name"]
      expect(partner.name_kana).to   eq dummy_response["partners"][0]["name_kana"]
      expect(partner.name_suffix).to eq dummy_response["partners"][0]["name_suffix"]
      expect(partner.memo).to        eq dummy_response["partners"][0]["memo"]
      expect(partner.created_at).to  eq dummy_response["partners"][0]["created_at"]
      expect(partner.updated_at).to  eq dummy_response["partners"][0]["updated_at"]
      expect(partner.departments).to be_a MfCloud::Invoice::Collection::DepartmentCollection

      department = partner.departments.first
      expect(department).to              be_a MfCloud::Invoice::Model::Department
      expect(department.id).to           eq dummy_response["partners"][0]["departments"][0]["id"]
      expect(department.name).to         eq dummy_response["partners"][0]["departments"][0]["name"]
      expect(department.zip).to          eq dummy_response["partners"][0]["departments"][0]["zip"]
      expect(department.tel).to          eq dummy_response["partners"][0]["departments"][0]["tel"]
      expect(department.prefecture).to   eq dummy_response["partners"][0]["departments"][0]["prefecture"]
      expect(department.address1).to     eq dummy_response["partners"][0]["departments"][0]["address1"]
      expect(department.address2).to     eq dummy_response["partners"][0]["departments"][0]["address2"]
      expect(department.person_title).to eq dummy_response["partners"][0]["departments"][0]["person_title"]
      expect(department.person_name).to  eq dummy_response["partners"][0]["departments"][0]["person_name"]
      expect(department.email).to        eq dummy_response["partners"][0]["departments"][0]["email"]
      expect(department.cc_emails).to    eq dummy_response["partners"][0]["departments"][0]["cc_emails"]
      expect(department.created_at).to   eq dummy_response["partners"][0]["departments"][0]["created_at"]
      expect(department.updated_at).to   eq dummy_response["partners"][0]["departments"][0]["updated_at"]
    end
  end

  describe '#get' do
    let(:dummy_id) { 'ABCDEFGHIJKLMN' }
    let(:dummy_response) do
      {
        "id"          => dummy_id,
        "code"        => "dummy_code",
        "name"        => "dummy_name",
        "name_kana"   => "ダミーネーム",
        "name_suffix" => "様",
        "memo"        => "dummy_memo",
        "created_at"  => "2016-01-01T00:00:00+0900",
        "updated_at"  => "2016-01-01T00:00:00+0900",
        "departments" => [
          {
            "id"           => "OPQRSTUVWXYZ",
            "name"         => "dummy_name",
            "zip"          => "123-1234",
            "tel"          => "03-1234-1234",
            "prefecture"   => "東京都",
            "address1"     => "dummy address1",
            "address2"     => "dummy address2",
            "person_title" => "dummy person title",
            "person_name"  => "dummy person name",
            "email"        => "dummy email",
            "cc_emails"    => "dummy cc_emails",
            "created_at"  => "2016-01-01T00:00:00+0900",
            "updated_at"  => "2016-01-01T00:00:00+0900"
          }
        ]
      }
    end

    subject { client.partners.get(dummy_id) }

    before do
      stub_request(:get, MfCloud::Invoice::API_URL + "v1/partners/#{dummy_id}")
        .to_return(status: 200, body: dummy_response.to_json)
    end

    it do
      expect(subject.id).to          eq dummy_id
      expect(subject.code).to        eq dummy_response["code"]
      expect(subject.name).to        eq dummy_response["name"]
      expect(subject.name_kana).to   eq dummy_response["name_kana"]
      expect(subject.name_suffix).to eq dummy_response["name_suffix"]
      expect(subject.memo).to        eq dummy_response["memo"]
      expect(subject.created_at).to  eq dummy_response["created_at"]
      expect(subject.updated_at).to  eq dummy_response["updated_at"]
      expect(subject.departments).to be_a MfCloud::Invoice::Collection::DepartmentCollection

      department = subject.departments.first
      expect(department).to              be_a MfCloud::Invoice::Model::Department
      expect(department.id).to           eq dummy_response["departments"][0]["id"]
      expect(department.name).to         eq dummy_response["departments"][0]["name"]
      expect(department.zip).to          eq dummy_response["departments"][0]["zip"]
      expect(department.tel).to          eq dummy_response["departments"][0]["tel"]
      expect(department.prefecture).to   eq dummy_response["departments"][0]["prefecture"]
      expect(department.address1).to     eq dummy_response["departments"][0]["address1"]
      expect(department.address2).to     eq dummy_response["departments"][0]["address2"]
      expect(department.person_title).to eq dummy_response["departments"][0]["person_title"]
      expect(department.person_name).to  eq dummy_response["departments"][0]["person_name"]
      expect(department.email).to        eq dummy_response["departments"][0]["email"]
      expect(department.cc_emails).to    eq dummy_response["departments"][0]["cc_emails"]
      expect(department.created_at).to   eq dummy_response["departments"][0]["created_at"]
      expect(department.updated_at).to   eq dummy_response["departments"][0]["updated_at"]
    end
  end

  describe '#create' do
    let(:dummy_params) do
      {
        "code"        => "dummy_code",
        "name"        => "dummy_name",
        "name_kana"   => "ダミーネーム",
        "name_suffix" => "様",
        "memo"        => "dummy_memo",
        "departments" => [
          {
            "name"         => "dummy_name",
            "zip"          => "123-1234",
            "tel"          => "03-1234-1234",
            "prefecture"   => "東京都",
            "address1"     => "dummy address1",
            "address2"     => "dummy address2",
            "person_title" => "dummy person title",
            "person_name"  => "dummy person name",
            "email"        => "dummy email",
            "cc_emails"    => "dummy cc_emails"
          }
        ]
      }
    end

    let(:dummy_response) do
      {
        "id"          => 'ABCDEFGHIJKLMN',
        "code"        => "dummy_code",
        "name"        => "dummy_name",
        "name_kana"   => "ダミーネーム",
        "name_suffix" => "様",
        "memo"        => "dummy_memo",
        "created_at"  => "2016-01-01T00:00:00+0900",
        "updated_at"  => "2016-01-01T00:00:00+0900",
        "departments" => [
          {
            "id"           => "OPQRSTUVWXYZ",
            "name"         => "dummy_name",
            "zip"          => "123-1234",
            "tel"          => "03-1234-1234",
            "prefecture"   => "東京都",
            "address1"     => "dummy address1",
            "address2"     => "dummy address2",
            "person_title" => "dummy person title",
            "person_name"  => "dummy person name",
            "email"        => "dummy email",
            "cc_emails"    => "dummy cc_emails",
            "created_at"   => "2016-01-01T00:00:00+0900",
            "updated_at"   => "2016-01-01T00:00:00+0900"
          }
        ]
      }
    end

    subject { client.partners.create(dummy_params) }

    before do
      stub_request(:post, MfCloud::Invoice::API_URL + "v1/partners")
        .with(body: { partner: dummy_params })
        .to_return(status: 200, body: dummy_response.to_json)
    end

    it do
      expect(subject.id).to          eq dummy_response["id"]
      expect(subject.code).to        eq dummy_response["code"]
      expect(subject.name).to        eq dummy_response["name"]
      expect(subject.name_kana).to   eq dummy_response["name_kana"]
      expect(subject.name_suffix).to eq dummy_response["name_suffix"]
      expect(subject.memo).to        eq dummy_response["memo"]
      expect(subject.created_at).to  eq dummy_response["created_at"]
      expect(subject.updated_at).to  eq dummy_response["updated_at"]
      expect(subject.departments).to be_a MfCloud::Invoice::Collection::DepartmentCollection

      department = subject.departments.first
      expect(department).to              be_a MfCloud::Invoice::Model::Department
      expect(department.id).to           eq dummy_response["departments"][0]["id"]
      expect(department.name).to         eq dummy_response["departments"][0]["name"]
      expect(department.zip).to          eq dummy_response["departments"][0]["zip"]
      expect(department.tel).to          eq dummy_response["departments"][0]["tel"]
      expect(department.prefecture).to   eq dummy_response["departments"][0]["prefecture"]
      expect(department.address1).to     eq dummy_response["departments"][0]["address1"]
      expect(department.address2).to     eq dummy_response["departments"][0]["address2"]
      expect(department.person_title).to eq dummy_response["departments"][0]["person_title"]
      expect(department.person_name).to  eq dummy_response["departments"][0]["person_name"]
      expect(department.email).to        eq dummy_response["departments"][0]["email"]
      expect(department.cc_emails).to    eq dummy_response["departments"][0]["cc_emails"]
      expect(department.created_at).to   eq dummy_response["departments"][0]["created_at"]
      expect(department.updated_at).to   eq dummy_response["departments"][0]["updated_at"]
    end
  end

  describe '#update' do
    let(:dummy_id) { 'ABCDEFGHIJKLMN' }

    let(:dummy_params) do
      {
        "code"        => "dummy_code",
        "name"        => "dummy_name",
        "name_kana"   => "ダミーネーム",
        "name_suffix" => "様",
        "memo"        => "dummy_memo",
        "departments" => [
          {
            "id"           => "OPQRSTUVWXYZ",
            "name"         => "dummy_name",
            "zip"          => "123-1234",
            "tel"          => "03-1234-1234",
            "prefecture"   => "東京都",
            "address1"     => "dummy address1",
            "address2"     => "dummy address2",
            "person_title" => "dummy person title",
            "person_name"  => "dummy person name",
            "email"        => "dummy email",
            "cc_emails"    => "dummy cc_emails"
          }
        ]
      }
    end

    let(:dummy_response) do
      {
        "id"          => dummy_id,
        "code"        => "dummy_code",
        "name"        => "dummy_name",
        "name_kana"   => "ダミーネーム",
        "name_suffix" => "様",
        "memo"        => "dummy_memo",
        "created_at"  => "2016-01-01T00:00:00+0900",
        "updated_at"  => "2016-01-01T00:00:00+0900",
        "departments" => [
          {
            "id"           => "OPQRSTUVWXYZ",
            "name"         => "dummy_name",
            "zip"          => "123-1234",
            "tel"          => "03-1234-1234",
            "prefecture"   => "東京都",
            "address1"     => "dummy address1",
            "address2"     => "dummy address2",
            "person_title" => "dummy person title",
            "person_name"  => "dummy person name",
            "email"        => "dummy email",
            "cc_emails"    => "dummy cc_emails",
            "created_at"   => "2016-01-01T00:00:00+0900",
            "updated_at"   => "2016-01-01T00:00:00+0900"
          }
        ]
      }
    end

    subject { client.partners.update(dummy_id, dummy_params) }

    before do
      stub_request(:put, MfCloud::Invoice::API_URL + "v1/partners/#{dummy_id}")
        .with(body: { partner: dummy_params })
        .to_return(status: 200, body: dummy_response.to_json)
    end

    it do
      expect(subject.id).to          eq dummy_id
      expect(subject.code).to        eq dummy_response["code"]
      expect(subject.name).to        eq dummy_response["name"]
      expect(subject.name_kana).to   eq dummy_response["name_kana"]
      expect(subject.name_suffix).to eq dummy_response["name_suffix"]
      expect(subject.memo).to        eq dummy_response["memo"]
      expect(subject.created_at).to  eq dummy_response["created_at"]
      expect(subject.updated_at).to  eq dummy_response["updated_at"]
      expect(subject.departments).to be_a MfCloud::Invoice::Collection::DepartmentCollection

      department = subject.departments.first
      expect(department).to              be_a MfCloud::Invoice::Model::Department
      expect(department.id).to           eq dummy_response["departments"][0]["id"]
      expect(department.name).to         eq dummy_response["departments"][0]["name"]
      expect(department.zip).to          eq dummy_response["departments"][0]["zip"]
      expect(department.tel).to          eq dummy_response["departments"][0]["tel"]
      expect(department.prefecture).to   eq dummy_response["departments"][0]["prefecture"]
      expect(department.address1).to     eq dummy_response["departments"][0]["address1"]
      expect(department.address2).to     eq dummy_response["departments"][0]["address2"]
      expect(department.person_title).to eq dummy_response["departments"][0]["person_title"]
      expect(department.person_name).to  eq dummy_response["departments"][0]["person_name"]
      expect(department.email).to        eq dummy_response["departments"][0]["email"]
      expect(department.cc_emails).to    eq dummy_response["departments"][0]["cc_emails"]
      expect(department.created_at).to   eq dummy_response["departments"][0]["created_at"]
      expect(department.updated_at).to   eq dummy_response["departments"][0]["updated_at"]
    end
  end

  describe '#delete' do
    let(:dummy_id) { 'ABCDEFGHIJKLMN' }

    subject { client.partners.delete(dummy_id) }

    before do
      stub_request(:delete, MfCloud::Invoice::API_URL + "v1/partners/#{dummy_id}")
        .to_return(status: 204)
    end

    it { is_expected.to be true }
  end
end
