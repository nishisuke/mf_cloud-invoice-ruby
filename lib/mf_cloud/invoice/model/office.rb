module MfCloud
  module Invoice
    module Model
      class Office < MfCloud::Invoice::Model::Base
        resource_attributes :name, :zip, :prefecture, :address1, :address2, :tel, :fax
      end
    end
  end
end
