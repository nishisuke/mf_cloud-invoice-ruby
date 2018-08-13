module MfCloud
  module Invoice
    module Api
      class BillingStatusPayment < MfCloud::Invoice::Api::Base
        BASE_NAME = 'billing_status'
        DEFAULT_VALUE = '0'
        NOT_TRANSFERRED_VALUE = '1'
        TRANSFERRED_VALUE = '2'

        allow_method :update

        def default!(billing_id)
          update(billing_id, { payment: DEFAULT_VALUE })
        end

        def not_transferred!(billing_id)
          update(billing_id, { payment: NOT_TRANSFERRED_VALUE })
        end

        def transferred!(billing_id)
          update(billing_id, { payment: TRANSFERRED_VALUE })
        end

        private

        def path(billing_id)
          "billings/#{billing_id}/billing_status/payment"
        end

        def model_class
          MfCloud::Invoice::Model::Billing
        end

        def update(billing_id, params)
          response_body = @client.put(path(billing_id), BASE_NAME => params)
          model_class.new(response_body)
        end
      end
    end
  end
end
