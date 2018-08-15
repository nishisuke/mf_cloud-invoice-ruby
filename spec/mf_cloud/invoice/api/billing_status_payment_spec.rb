require 'spec_helper'

describe MfCloud::Invoice::Api::BillingStatusPayment do
  let(:client) do
    MfCloud::Invoice::Client.new(
      client_id:     'client_id',
      client_secret: 'client_secret',
      access_token:  'access_token'
    )
  end

  let(:id) { 'ABCDEFGHIJKLMN' }
  let(:dummy_response) do
    {
      'id':                  id,
      'pdf_url':             'https://invoice.moneyforward.com/v1/api/billings/ABCDEFGHIJKLMN.pdf',
      'user_id':             'ABCDEFGHIJKLMN',
      'partner_id':          'ABCDEFGHIJKLMN',
      'department_id':       'ABCDEFGHIJKLMN',
      'partner_name':        'sample name',
      'partner_name_suffix': '様',
      'partner_detail':      'sample detail',
      'member_id':           'ABCDEFGHIJKLMN',
      'member_name':         'sample name',
      'office_name':         'sample name',
      'office_detail':       'sample detail',
      'title':               'sample title',
      'excise_price':        80,
      'deduct_price':        0,
      'subtotal':            1000,
      'memo':                'sample_memo',
      'payment_condition':   'sample condition',
      'total_price':         1080,
      'billing_date':        '2016-01-01',
      'due_date':            '2016-01-31',
      'sales_date':          '2015-12-31',
      'billing_number':      '1',
      'note':                'sample note',
      'document_name':       'sample name',
      'tags':                'tag1, tag2',
      'created_at':          '2016-01-01T00:00:00+0900',
      'updated_at':          '2016-01-01T00:00:00+0900',
      'items': [
        {
          'id':         'ABCDEFGHIJKLMN',
          'code':       'dummy_code',
          'name':       'dummy_name',
          'detail':     'dummy_detail',
          'unit_price': 100,
          'quantity':   1,
          'price':      100,
          'excise':     true,
          'created_at': '2016-01-01 00:00:00',
          'updated_at': '2016-01-01 00:00:00'
        }
      ],
      'status':         {
        'posting':      '未郵送',
        'email':        '未送信',
        'download':     '',
        'payment':      payment_status_in_ja
      }
    }
  end

  before do
    stub_request(:put, MfCloud::Invoice::API_URL + "v1/billings/#{id}/billing_status/payment")
      .with(body: { billing_status: { payment: payment_status } })
      .to_return(status: 200, body: dummy_response.to_json)
  end

  shared_examples 'returning expected response' do
    it { is_expected.to be_a MfCloud::Invoice::Model::Billing }
    it 'Changes payment status' do
      expect(subject.status.payment).to eq payment_status_in_ja
    end
  end

  describe '#default!' do
    let(:payment_status) { '0' }
    let(:payment_status_in_ja) { '未設定' }
    subject { client.billing_status_payment.default!(id) }
    it_behaves_like 'returning expected response'
  end

  describe '#not_transferred!' do
    let(:payment_status) { '1' }
    let(:payment_status_in_ja) { '未入金' }
    subject { client.billing_status_payment.not_transferred!(id) }
    it_behaves_like 'returning expected response'
  end

  describe '#transferred!' do
    let(:payment_status) { '2' }
    let(:payment_status_in_ja) { '入金済み' }
    subject { client.billing_status_payment.transferred!(id) }
    it_behaves_like 'returning expected response'
  end
end
