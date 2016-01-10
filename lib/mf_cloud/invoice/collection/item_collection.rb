module MfCloud
  module Invoice
    module Collection
      class ItemCollection < MfCloud::Invoice::Collection::Base
        def initialize(collection_params = [], meta_params = {})
          @meta = MfCloud::Invoice::Collection::MetaData.new(meta_params)
          @collection = collection_params.map do |item_params|
            MfCloud::Invoice::Model::Item.new(item_params)
          end
        end
      end
    end
  end
end
