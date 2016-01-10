module MfCloud
  module Invoice
    module Api
      class Base
        class << self
          def model_name
            name.sub('Api', 'Model')
          end

          def model_class
            Object.const_get(model_name)
          end

          def collection_name
            "#{name.sub('Api', 'Collection')}Collection"
          end

          def collection_class
            Object.const_get(collection_name)
          end

          def allowed_methods
            @allowed_methods ||= []
          end

          private

          def allow_method(*methods)
            @allowed_methods = methods
          end
        end

        def initialize(client)
          @client = client
        end

        def all(params = {})
          fail MethodNotAllowed, "#{self.class.name} has not allowed :all" unless self.class.allowed_methods.include? :all

          response_body = @client.get(self.class::PATH, params)
          self.class.collection_class.new(
            response_body[self.class::COLLECTION_KEY],
            response_body["meta"]
          )
        end

        def get(id)
          fail MethodNotAllowed, "#{self.class.name} has not allowed :get" unless self.class.allowed_methods.include? :get

          response_body = @client.get("#{self.class::PATH}/#{id}")
          self.class.model_class.new(response_body)
        end

        def create(params)
          fail MethodNotAllowed, "#{self.class.name} has not allowed :create" unless self.class.allowed_methods.include? :create

          response_body = @client.post(self.class::PATH, self.class::BASE_NAME => params)
          self.class.model_class.new(response_body)
        end

        def update(id, params)
          fail MethodNotAllowed, "#{self.class.name} has not allowed :update" unless self.class.allowed_methods.include? :update

          response_body = @client.put("#{self.class::PATH}/#{id}", self.class::BASE_NAME => params)
          self.class.model_class.new(response_body)
        end

        def delete(id)
          fail MethodNotAllowed, "#{self.class.name} has not allowed :delete" unless self.class.allowed_methods.include? :delete

          @client.delete("#{self.class::PATH}/#{id}")
        end
      end
    end
  end
end
