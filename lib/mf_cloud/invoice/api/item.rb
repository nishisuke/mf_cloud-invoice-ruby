module MfCloud
  module Invoice
    module Api
      class Item < MfCloud::Invoice::Api::Base
        BASE_NAME      = 'item'
        COLLECTION_KEY = 'items'
        PATH           = 'items'

        allow_method :all, :get, :create, :update, :delete
      end
    end
  end
end
