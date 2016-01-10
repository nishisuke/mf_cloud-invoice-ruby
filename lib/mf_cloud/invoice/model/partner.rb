module MfCloud
  module Invoice
    module Model
      class Partner < MfCloud::Invoice::Model::Base
        resource_attributes :id, :code, :name, :name_kana, :name_suffix, :memo, :created_at, :updated_at
        attr_reader :departments

        def initialize(params)
          super
          @departments = MfCloud::Invoice::Collection::DepartmentCollection.new(params["departments"])
        end
      end
    end
  end
end
