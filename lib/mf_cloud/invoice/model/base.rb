module MfCloud
  module Invoice
    module Model
      class Base
        class << self
          def attribute_keys
            @attribute_keys ||= []
          end

          private

          def resource_attributes(*attributes)
            attributes.each { |attribute| attr_accessor attribute }
            attribute_keys.concat(attributes)
          end
        end

        def initialize(params)
          set_attributes(params)
        end

        private

        def set_attributes(params)
          self.class.attribute_keys.each do |attr|
            __send__("#{attr}=", params[attr.to_s]) unless params[attr.to_s].nil?
          end
        end
      end
    end
  end
end
