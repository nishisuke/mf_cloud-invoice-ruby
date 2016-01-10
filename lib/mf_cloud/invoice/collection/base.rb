module MfCloud
  module Invoice
    module Collection
      class Base
        attr_reader :meta

        def collection
          @collection ||= []
        end

        private

        def method_missing(method_name, *args , &block)
          if collection.respond_to? method_name
            collection.__send__(method_name, *args, &block)
          else
            super
          end
        end
      end
    end
  end
end
