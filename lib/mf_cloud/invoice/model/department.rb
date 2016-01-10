module MfCloud
  module Invoice
    module Model
      class Department < MfCloud::Invoice::Model::Base
        resource_attributes :id, :name, :zip, :tel, :prefecture, :address1, :address2,
          :person_title, :person_name, :email, :cc_emails, :created_at, :updated_at
      end
    end
  end
end
