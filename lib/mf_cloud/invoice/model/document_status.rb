module MfCloud
  module Invoice
    module Model
      class DocumentStatus < MfCloud::Invoice::Model::Base
        resource_attributes :posting, :email, :download, :payment
      end
    end
  end
end
