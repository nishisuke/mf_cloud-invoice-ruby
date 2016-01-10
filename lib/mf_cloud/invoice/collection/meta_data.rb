module MfCloud
  module Invoice
    module Collection
      class MetaData < MfCloud::Invoice::Model::Base
        resource_attributes :total_count, :total_pages, :current_page, :per_page
      end
    end
  end
end
