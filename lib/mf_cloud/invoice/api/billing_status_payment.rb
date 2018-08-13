module MfCloud
  module Invoice
    module Api
      class BillingStatusPayment < MfCloud::Invoice::Api::Base
        BASE_NAME = 'billing_status'

        allow_method :update

        def default!(billing_id)
          update(billing_id, { payment: 0 })
        end

        def not_transferred!(billing_id)
          update(billing_id, { payment: 1 })
        end

        def transferred!(billing_id)
          update(billing_id, { payment: 2 })
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
