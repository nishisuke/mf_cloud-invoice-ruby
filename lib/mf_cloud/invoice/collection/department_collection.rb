module MfCloud
  module Invoice
    module Collection
      class DepartmentCollection < MfCloud::Invoice::Collection::Base
        def initialize(collection_params = [])
          @collection = collection_params.map do |department_params|
            MfCloud::Invoice::Model::Department.new(department_params)
          end
        end
      end
    end
  end
end
