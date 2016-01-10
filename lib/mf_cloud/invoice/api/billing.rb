module MfCloud
  module Invoice
    module Api
      class Billing < MfCloud::Invoice::Api::Base
        BASE_NAME      = 'billing'
        COLLECTION_KEY = 'billings'
        PATH           = 'billings'

        allow_method :all, :get, :create, :update, :delete
      end
    end
  end
end
