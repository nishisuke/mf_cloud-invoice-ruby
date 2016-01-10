require 'spec_helper'

describe MfCloud::Invoice::Api::Billing do
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
          "per_page"     => 10
        },
        "billings" => [
          {
            "id" => 'ABCDEFGHIJKLMN',
            "pdf_url" => 'https://invoice.moneyforward.com/v1/api/billings/ABCDEFGHIJKLMN.pdf',
            "user_id" => 'ABCDEFGHIJKLMN',
            "partner_id" => 'ABCDEFGHIJKLMN',
            "department_id" => 'ABCDEFGHIJKLMN',
            "partner_name" => 'sample name',
            "partner_name_suffix" => '様',
            "partner_detail" => 'sample detail',
            "member_id" => 'ABCDEFGHIJKLMN',
            "member_name" => 'sample name',
            "office_name" => 'sample name',
            "office_detail" => 'sample detail',
            "title" => 'sample title',
            "excise_price" => 80,
            "deduct_price" => 0,
            "subtotal" => 1000,
            "memo" => 'sample_memo',
            "payment_condition" => 'sample condition',
            "total_price" => 1080,
            "billing_date" => '2016-01-01',
            "due_date" => '2016-01-31',
            "sales_date" => '2015-12-31',
            "billing_number" => '1',
            "note" => 'sample note',
            "document_name" => 'sample name',
            "tags" => 'tag1, tag2',
            "created_at"   => "2016-01-01T00:00:00+0900",
            "updated_at"   => "2016-01-01T00:00:00+0900",
            "items" => [
              {
                "id"         =>  'ABCDEFGHIJKLMN',
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
            ],
            "status" => {
              "posting"  => "未郵送",
              "email"    => "未送信",
              "download" => "",
              "payment"  => "未設定"
            }
          },
          {
            "id" => 'ABCDEFGHIJKLMN',
            "pdf_url" => 'https://invoice.moneyforward.com/v1/api/billings/ABCDEFGHIJKLMN.pdf',
            "user_id" => 'ABCDEFGHIJKLMN',
            "partner_id" => 'ABCDEFGHIJKLMN',
            "department_id" => 'ABCDEFGHIJKLMN',
            "partner_name" => 'sample name',
            "partner_name_suffix" => '様',
            "partner_detail" => 'sample detail',
            "member_id" => 'ABCDEFGHIJKLMN',
            "member_name" => 'sample name',
            "office_name" => 'sample name',
            "office_detail" => 'sample detail',
            "title" => 'sample title',
            "excise_price" => 80,
            "deduct_price" => 0,
            "subtotal" => 1000,
            "memo" => 'sample_memo',
            "payment_condition" => 'sample condition',
            "total_price" => 1080,
            "billing_date" => '2016-01-01',
            "due_date" => '2016-01-31',
            "sales_date" => '2015-12-31',
            "billing_number" => '1',
            "note" => 'sample note',
            "document_name" => 'sample name',
            "tags" => 'tag1, tag2',
            "created_at"   => "2016-01-01T00:00:00+0900",
            "updated_at"   => "2016-01-01T00:00:00+0900",
            "items" => [
              {
                "id"         =>  'ABCDEFGHIJKLMN',
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
            ],
            "status" => {
              "posting"  => "未郵送",
              "email"    => "未送信",
              "download" => "",
              "payment"  => "未設定"
            }
          }
        ]
      }
    end

    subject { client.billings.all }

    before do
      stub_request(:get, MfCloud::Invoice::API_URL + "v1/billings")
        .to_return(status: 200, body: dummy_response.to_json )
    end

    it do
      expect(subject).to be_a MfCloud::Invoice::Collection::BillingCollection
      expect(subject.count).to eq 2
      billing = subject.first
      expect(billing.id).to                  eq dummy_response["billings"][0]["id"]
      expect(billing.pdf_url).to             eq dummy_response["billings"][0]["pdf_url"]
      expect(billing.user_id).to             eq dummy_response["billings"][0]["user_id"]
      expect(billing.partner_id).to          eq dummy_response["billings"][0]["partner_id"]
      expect(billing.department_id).to       eq dummy_response["billings"][0]["department_id"]
      expect(billing.partner_name).to        eq dummy_response["billings"][0]["partner_name"]
      expect(billing.partner_name_suffix).to eq dummy_response["billings"][0]["partner_name_suffix"]
      expect(billing.partner_detail).to      eq dummy_response["billings"][0]["partner_detail"]
      expect(billing.member_id).to           eq dummy_response["billings"][0]["member_id"]
      expect(billing.member_name).to         eq dummy_response["billings"][0]["member_name"]
      expect(billing.office_name).to         eq dummy_response["billings"][0]["office_name"]
      expect(billing.office_detail).to       eq dummy_response["billings"][0]["office_detail"]
      expect(billing.title).to               eq dummy_response["billings"][0]["title"]
      expect(billing.excise_price).to        eq dummy_response["billings"][0]["excise_price"]
      expect(billing.deduct_price).to        eq dummy_response["billings"][0]["deduct_price"]
      expect(billing.subtotal).to            eq dummy_response["billings"][0]["subtotal"]
      expect(billing.memo).to                eq dummy_response["billings"][0]["memo"]
      expect(billing.payment_condition).to   eq dummy_response["billings"][0]["payment_condition"]
      expect(billing.total_price).to         eq dummy_response["billings"][0]["total_price"]
      expect(billing.billing_date).to        eq dummy_response["billings"][0]["billing_date"]
      expect(billing.due_date).to            eq dummy_response["billings"][0]["due_date"]
      expect(billing.sales_date).to          eq dummy_response["billings"][0]["sales_date"]
      expect(billing.billing_number).to      eq dummy_response["billings"][0]["billing_number"]
      expect(billing.note).to                eq dummy_response["billings"][0]["note"]
      expect(billing.document_name).to       eq dummy_response["billings"][0]["document_name"]
      expect(billing.tags).to                eq dummy_response["billings"][0]["tags"]
      expect(billing.created_at).to          eq dummy_response["billings"][0]["created_at"]
      expect(billing.updated_at).to          eq dummy_response["billings"][0]["updated_at"]
      expect(billing.items).to               be_a MfCloud::Invoice::Collection::ItemCollection

      item = billing.items.first
      expect(item).to be_a MfCloud::Invoice::Model::Item
      expect(item.id).to         eq dummy_response["billings"][0]["items"][0]["id"]
      expect(item.code).to       eq dummy_response["billings"][0]["items"][0]["code"]
      expect(item.name).to       eq dummy_response["billings"][0]["items"][0]["name"]
      expect(item.detail).to     eq dummy_response["billings"][0]["items"][0]["detail"]
      expect(item.unit_price).to eq dummy_response["billings"][0]["items"][0]["unit_price"]
      expect(item.quantity).to   eq dummy_response["billings"][0]["items"][0]["quantity"]
      expect(item.price).to      eq dummy_response["billings"][0]["items"][0]["price"]
      expect(item.excise).to     eq dummy_response["billings"][0]["items"][0]["excise"]
      expect(item.created_at).to eq dummy_response["billings"][0]["items"][0]["created_at"]
      expect(item.updated_at).to eq dummy_response["billings"][0]["items"][0]["updated_at"]

      status = billing.status
      expect(status.posting).to  eq dummy_response["billings"][0]["status"]["posting"]
      expect(status.email).to    eq dummy_response["billings"][0]["status"]["email"]
      expect(status.download).to eq dummy_response["billings"][0]["status"]["download"]
      expect(status.payment).to  eq dummy_response["billings"][0]["status"]["payment"]
    end
  end

  describe '#get' do
    let(:dummy_id) { 'ABCDEFGHIJKLMN' }
    let(:dummy_response) do
      {
        "id" => dummy_id,
        "pdf_url" => 'https://invoice.moneyforward.com/v1/api/billings/ABCDEFGHIJKLMN.pdf',
        "user_id" => 'ABCDEFGHIJKLMN',
        "partner_id" => 'ABCDEFGHIJKLMN',
        "department_id" => 'ABCDEFGHIJKLMN',
        "partner_name" => 'sample name',
        "partner_name_suffix" => '様',
        "partner_detail" => 'sample detail',
        "member_id" => 'ABCDEFGHIJKLMN',
        "member_name" => 'sample name',
        "office_name" => 'sample name',
        "office_detail" => 'sample detail',
        "title" => 'sample title',
        "excise_price" => 80,
        "deduct_price" => 0,
        "subtotal" => 1000,
        "memo" => 'sample_memo',
        "payment_condition" => 'sample condition',
        "total_price" => 1080,
        "billing_date" => '2016-01-01',
        "due_date" => '2016-01-31',
        "sales_date" => '2015-12-31',
        "billing_number" => '1',
        "note" => 'sample note',
        "document_name" => 'sample name',
        "tags" => 'tag1, tag2',
        "created_at"   => "2016-01-01T00:00:00+0900",
        "updated_at"   => "2016-01-01T00:00:00+0900",
        "items" => [
          {
            "id"         =>  'ABCDEFGHIJKLMN',
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
        ],
        "status" => {
          "posting"  => "未郵送",
          "email"    => "未送信",
          "download" => "",
          "payment"  => "未設定"
        }
      }
    end

    subject { client.billings.get(dummy_id) }

    before do
      stub_request(:get, MfCloud::Invoice::API_URL + "v1/billings/#{dummy_id}")
        .to_return(status: 200, body: dummy_response.to_json)
    end

    it do
      expect(subject).to                     be_a MfCloud::Invoice::Model::Billing
      expect(subject.id).to                  eq dummy_response["id"]
      expect(subject.pdf_url).to             eq dummy_response["pdf_url"]
      expect(subject.user_id).to             eq dummy_response["user_id"]
      expect(subject.partner_id).to          eq dummy_response["partner_id"]
      expect(subject.department_id).to       eq dummy_response["department_id"]
      expect(subject.partner_name).to        eq dummy_response["partner_name"]
      expect(subject.partner_name_suffix).to eq dummy_response["partner_name_suffix"]
      expect(subject.partner_detail).to      eq dummy_response["partner_detail"]
      expect(subject.member_id).to           eq dummy_response["member_id"]
      expect(subject.member_name).to         eq dummy_response["member_name"]
      expect(subject.office_name).to         eq dummy_response["office_name"]
      expect(subject.office_detail).to       eq dummy_response["office_detail"]
      expect(subject.title).to               eq dummy_response["title"]
      expect(subject.excise_price).to        eq dummy_response["excise_price"]
      expect(subject.deduct_price).to        eq dummy_response["deduct_price"]
      expect(subject.subtotal).to            eq dummy_response["subtotal"]
      expect(subject.memo).to                eq dummy_response["memo"]
      expect(subject.payment_condition).to   eq dummy_response["payment_condition"]
      expect(subject.total_price).to         eq dummy_response["total_price"]
      expect(subject.billing_date).to        eq dummy_response["billing_date"]
      expect(subject.due_date).to            eq dummy_response["due_date"]
      expect(subject.sales_date).to          eq dummy_response["sales_date"]
      expect(subject.billing_number).to      eq dummy_response["billing_number"]
      expect(subject.note).to                eq dummy_response["note"]
      expect(subject.document_name).to       eq dummy_response["document_name"]
      expect(subject.tags).to                eq dummy_response["tags"]
      expect(subject.created_at).to          eq dummy_response["created_at"]
      expect(subject.updated_at).to          eq dummy_response["updated_at"]
      expect(subject.items).to               be_a MfCloud::Invoice::Collection::ItemCollection

      item = subject.items.first
      expect(item).to be_a MfCloud::Invoice::Model::Item
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

      status = subject.status
      expect(status.posting).to  eq dummy_response["status"]["posting"]
      expect(status.email).to    eq dummy_response["status"]["email"]
      expect(status.download).to eq dummy_response["status"]["download"]
      expect(status.payment).to  eq dummy_response["status"]["payment"]
    end
  end

  describe '#create' do
    let(:dummy_params) do
      {
        "department_id" => 'ABCDEFGHIJKLMN',
        "title" => 'sample title',
        "memo" => 'sample_memo',
        "payment_condition" => 'sample condition',
        "billing_date" => '2016-01-01',
        "due_date" => '2016-01-31',
        "sales_date" => '2015-12-31',
        "billing_number" => '1',
        "note" => 'sample note',
        "document_name" => 'sample name',
        "tags" => 'tag1, tag2',
        "items" => [
          {
            "code"       => "dummy_code",
            "name"       => "dummy_name",
            "detail"     => "dummy_detail",
            "unit_price" => 100,
            "quantity"   => 1,
            "excise"     => true
          }
        ]
      }
    end

    let(:dummy_response) do
      {
        "id" => 'ABCDEFGHIJKLMN',
        "pdf_url" => 'https://invoice.moneyforward.com/v1/api/billings/ABCDEFGHIJKLMN.pdf',
        "user_id" => 'ABCDEFGHIJKLMN',
        "partner_id" => 'ABCDEFGHIJKLMN',
        "department_id" => 'ABCDEFGHIJKLMN',
        "partner_name" => 'sample name',
        "partner_name_suffix" => '様',
        "partner_detail" => 'sample detail',
        "member_id" => 'ABCDEFGHIJKLMN',
        "member_name" => 'sample name',
        "office_name" => 'sample name',
        "office_detail" => 'sample detail',
        "title" => 'sample title',
        "excise_price" => 80,
        "deduct_price" => 0,
        "subtotal" => 1000,
        "memo" => 'sample_memo',
        "payment_condition" => 'sample condition',
        "total_price" => 1080,
        "billing_date" => '2016-01-01',
        "due_date" => '2016-01-31',
        "sales_date" => '2015-12-31',
        "billing_number" => '1',
        "note" => 'sample note',
        "document_name" => 'sample name',
        "tags" => 'tag1, tag2',
        "created_at"   => "2016-01-01T00:00:00+0900",
        "updated_at"   => "2016-01-01T00:00:00+0900",
        "items" => [
          {
            "id"         =>  'ABCDEFGHIJKLMN',
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
        ],
        "status" => {
          "posting"  => "未郵送",
          "email"    => "未送信",
          "download" => "",
          "payment"  => "未設定"
        }
      }
    end

    subject { client.billings.create(dummy_params) }

    before do
      stub_request(:post, MfCloud::Invoice::API_URL + "v1/billings")
        .with(body: { billing: dummy_params })
        .to_return(status: 200, body: dummy_response.to_json)
    end

    it do
      expect(subject).to                     be_a MfCloud::Invoice::Model::Billing
      expect(subject.id).to                  eq dummy_response["id"]
      expect(subject.pdf_url).to             eq dummy_response["pdf_url"]
      expect(subject.user_id).to             eq dummy_response["user_id"]
      expect(subject.partner_id).to          eq dummy_response["partner_id"]
      expect(subject.department_id).to       eq dummy_response["department_id"]
      expect(subject.partner_name).to        eq dummy_response["partner_name"]
      expect(subject.partner_name_suffix).to eq dummy_response["partner_name_suffix"]
      expect(subject.partner_detail).to      eq dummy_response["partner_detail"]
      expect(subject.member_id).to           eq dummy_response["member_id"]
      expect(subject.member_name).to         eq dummy_response["member_name"]
      expect(subject.office_name).to         eq dummy_response["office_name"]
      expect(subject.office_detail).to       eq dummy_response["office_detail"]
      expect(subject.title).to               eq dummy_response["title"]
      expect(subject.excise_price).to        eq dummy_response["excise_price"]
      expect(subject.deduct_price).to        eq dummy_response["deduct_price"]
      expect(subject.subtotal).to            eq dummy_response["subtotal"]
      expect(subject.memo).to                eq dummy_response["memo"]
      expect(subject.payment_condition).to   eq dummy_response["payment_condition"]
      expect(subject.total_price).to         eq dummy_response["total_price"]
      expect(subject.billing_date).to        eq dummy_response["billing_date"]
      expect(subject.due_date).to            eq dummy_response["due_date"]
      expect(subject.sales_date).to          eq dummy_response["sales_date"]
      expect(subject.billing_number).to      eq dummy_response["billing_number"]
      expect(subject.note).to                eq dummy_response["note"]
      expect(subject.document_name).to       eq dummy_response["document_name"]
      expect(subject.tags).to                eq dummy_response["tags"]
      expect(subject.created_at).to          eq dummy_response["created_at"]
      expect(subject.updated_at).to          eq dummy_response["updated_at"]
      expect(subject.items).to               be_a MfCloud::Invoice::Collection::ItemCollection

      item = subject.items.first
      expect(item).to be_a MfCloud::Invoice::Model::Item
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

      status = subject.status
      expect(status.posting).to  eq dummy_response["status"]["posting"]
      expect(status.email).to    eq dummy_response["status"]["email"]
      expect(status.download).to eq dummy_response["status"]["download"]
      expect(status.payment).to  eq dummy_response["status"]["payment"]
    end
  end

  describe '#update' do
    let(:dummy_id) { 'ABCDEFGHIJKLMN' }

    let(:dummy_params) do
      {
        "department_id" => 'ABCDEFGHIJKLMN',
        "partner_name" => 'sample name',
        "partner_name_suffix" => '様',
        "partner_detail" => 'sample detail',
        "member_id" => 'ABCDEFGHIJKLMN',
        "member_name" => 'sample name',
        "title" => 'sample title',
        "memo" => 'sample_memo',
        "payment_condition" => 'sample condition',
        "billing_date" => '2016-01-01',
        "due_date" => '2016-01-31',
        "sales_date" => '2015-12-31',
        "billing_number" => '1',
        "note" => 'sample note',
        "document_name" => 'sample name',
        "tags" => 'tag1, tag2',
        "items" => [
          {
            "id"         =>  'ABCDEFGHIJKLMN',
            "code"       => "dummy_code",
            "name"       => "dummy_name",
            "detail"     => "dummy_detail",
            "unit_price" => 100,
            "quantity"   => 1,
            "price"      => 100,
            "excise"     => true,
          }
        ]
      }
    end

    let(:dummy_response) do
      {
        "id" => 'ABCDEFGHIJKLMN',
        "pdf_url" => 'https://invoice.moneyforward.com/v1/api/billings/ABCDEFGHIJKLMN.pdf',
        "user_id" => 'ABCDEFGHIJKLMN',
        "partner_id" => 'ABCDEFGHIJKLMN',
        "department_id" => 'ABCDEFGHIJKLMN',
        "partner_name" => 'sample name',
        "partner_name_suffix" => '様',
        "partner_detail" => 'sample detail',
        "member_id" => 'ABCDEFGHIJKLMN',
        "member_name" => 'sample name',
        "office_name" => 'sample name',
        "office_detail" => 'sample detail',
        "title" => 'sample title',
        "excise_price" => 80,
        "deduct_price" => 0,
        "subtotal" => 1000,
        "memo" => 'sample_memo',
        "payment_condition" => 'sample condition',
        "total_price" => 1080,
        "billing_date" => '2016-01-01',
        "due_date" => '2016-01-31',
        "sales_date" => '2015-12-31',
        "billing_number" => '1',
        "note" => 'sample note',
        "document_name" => 'sample name',
        "tags" => 'tag1, tag2',
        "created_at"   => "2016-01-01T00:00:00+0900",
        "updated_at"   => "2016-01-01T00:00:00+0900",
        "items" => [
          {
            "id"         =>  'ABCDEFGHIJKLMN',
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
        ],
        "status" => {
          "posting"  => "未郵送",
          "email"    => "未送信",
          "download" => "",
          "payment"  => "未設定"
        }
      }
    end

    subject { client.billings.update(dummy_id, dummy_params) }

    before do
      stub_request(:put, MfCloud::Invoice::API_URL + "v1/billings/#{dummy_id}")
        .with(body: { billing: dummy_params })
        .to_return(status: 200, body: dummy_response.to_json)
    end

    it do
      expect(subject).to                     be_a MfCloud::Invoice::Model::Billing
      expect(subject.id).to                  eq dummy_response["id"]
      expect(subject.pdf_url).to             eq dummy_response["pdf_url"]
      expect(subject.user_id).to             eq dummy_response["user_id"]
      expect(subject.partner_id).to          eq dummy_response["partner_id"]
      expect(subject.department_id).to       eq dummy_response["department_id"]
      expect(subject.partner_name).to        eq dummy_response["partner_name"]
      expect(subject.partner_name_suffix).to eq dummy_response["partner_name_suffix"]
      expect(subject.partner_detail).to      eq dummy_response["partner_detail"]
      expect(subject.member_id).to           eq dummy_response["member_id"]
      expect(subject.member_name).to         eq dummy_response["member_name"]
      expect(subject.office_name).to         eq dummy_response["office_name"]
      expect(subject.office_detail).to       eq dummy_response["office_detail"]
      expect(subject.title).to               eq dummy_response["title"]
      expect(subject.excise_price).to        eq dummy_response["excise_price"]
      expect(subject.deduct_price).to        eq dummy_response["deduct_price"]
      expect(subject.subtotal).to            eq dummy_response["subtotal"]
      expect(subject.memo).to                eq dummy_response["memo"]
      expect(subject.payment_condition).to   eq dummy_response["payment_condition"]
      expect(subject.total_price).to         eq dummy_response["total_price"]
      expect(subject.billing_date).to        eq dummy_response["billing_date"]
      expect(subject.due_date).to            eq dummy_response["due_date"]
      expect(subject.sales_date).to          eq dummy_response["sales_date"]
      expect(subject.billing_number).to      eq dummy_response["billing_number"]
      expect(subject.note).to                eq dummy_response["note"]
      expect(subject.document_name).to       eq dummy_response["document_name"]
      expect(subject.tags).to                eq dummy_response["tags"]
      expect(subject.created_at).to          eq dummy_response["created_at"]
      expect(subject.updated_at).to          eq dummy_response["updated_at"]
      expect(subject.items).to               be_a MfCloud::Invoice::Collection::ItemCollection

      item = subject.items.first
      expect(item).to be_a MfCloud::Invoice::Model::Item
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

      status = subject.status
      expect(status.posting).to  eq dummy_response["status"]["posting"]
      expect(status.email).to    eq dummy_response["status"]["email"]
      expect(status.download).to eq dummy_response["status"]["download"]
      expect(status.payment).to  eq dummy_response["status"]["payment"]
    end
  end

  describe '#delete' do
    let(:dummy_id) { 'ABCDEFGHIJKLMN' }

    subject { client.billings.delete(dummy_id) }

    before do
      stub_request(:delete, MfCloud::Invoice::API_URL + "v1/billings/#{dummy_id}")
        .to_return(status: 204)
    end

    it { is_expected.to be true }
  end
end
