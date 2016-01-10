module MfCloud
  module Invoice
    module Collection
      class BillingCollection < MfCloud::Invoice::Collection::Base
        def initialize(collection_params = [], meta_params = {})
          @meta = MfCloud::Invoice::Collection::MetaData.new(meta_params)
          @collection = collection_params.map do |billing_params|
            MfCloud::Invoice::Model::Billing.new(billing_params)
          end
        end
      end
    end
  end
end
