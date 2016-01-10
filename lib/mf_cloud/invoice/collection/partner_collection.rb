module MfCloud
  module Invoice
    module Collection
      class PartnerCollection < MfCloud::Invoice::Collection::Base
        def initialize(collection_params = [], meta_params = {})
          @meta = MfCloud::Invoice::Collection::MetaData.new(meta_params)
          @collection = collection_params.map do |partner_params|
            MfCloud::Invoice::Model::Partner.new(partner_params)
          end
        end
      end
    end
  end
end
