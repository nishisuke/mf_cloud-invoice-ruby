module MfCloud
  module Invoice
    module Api
      class BillingStatusPayment < MfCloud::Invoice::Api::Base
        BASE_NAME = 'billing_status'

        allow_method :update

        def update(billing_id, params)
          response_body = @client.put(path(billing_id), BASE_NAME => params)
          model_class.new(response_body)
        end

        private

        def path(billing_id)
          "billings/#{billing_id}/billing_status/payment"
        end

        def model_class
          MfCloud::Invoice::Model::Billing
        end
      end
    end
  end
end
