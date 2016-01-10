module MfCloud
  module Invoice
    module Model
      class Billing < MfCloud::Invoice::Model::Base
        resource_attributes :id, :pdf_url, :user_id, :partner_id, :department_id, :partner_name, :partner_name_suffix,
          :partner_detail, :member_id, :member_name, :office_name, :office_detail, :title, :excise_price, :deduct_price,
          :subtotal, :memo, :payment_condition, :total_price, :billing_date, :due_date, :sales_date, :created_at, :updated_at,
          :billing_number, :note, :document_name, :tags

        attr_reader :items, :status

        def initialize(params)
          super
          @items = MfCloud::Invoice::Collection::ItemCollection.new(params["items"])
          @status = MfCloud::Invoice::Model::DocumentStatus.new(params["status"])
        end
      end
    end
  end
end
