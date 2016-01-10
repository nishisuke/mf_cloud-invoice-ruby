module MfCloud
  module Invoice
    module Api
      class Office < MfCloud::Invoice::Api::Base
        PATH = 'office'

        def get
          response_body = @client.get(PATH)
          MfCloud::Invoice::Model::Office.new(response_body)
        end

        def update(params)
          response_body = @client.put(PATH, office: params)
          MfCloud::Invoice::Model::Office.new(response_body)
        end
      end
    end
  end
end
