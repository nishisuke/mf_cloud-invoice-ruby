module MfCloud
  module Invoice
    module Model
      class Item < MfCloud::Invoice::Model::Base
        resource_attributes :id, :code, :name, :detail, :unit_price, :unit,
          :quantity, :price, :excise, :created_at, :updated_at
      end
    end
  end
end
