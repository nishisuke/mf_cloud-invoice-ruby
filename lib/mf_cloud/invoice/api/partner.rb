module MfCloud
  module Invoice
    module Api
      class Partner < MfCloud::Invoice::Api::Base
        BASE_NAME      = 'partner'
        COLLECTION_KEY = 'partners'
        PATH           = 'partners'

        allow_method :all, :get, :create, :update, :delete
      end
    end
  end
end
