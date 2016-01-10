require 'faraday'
require 'faraday_middleware'

require 'mf_cloud/invoice/api/base'
require 'mf_cloud/invoice/api/office'
require 'mf_cloud/invoice/api/partner'
require 'mf_cloud/invoice/api/item'
require 'mf_cloud/invoice/api/billing'

require 'mf_cloud/invoice/model/base'
require 'mf_cloud/invoice/model/office'
require 'mf_cloud/invoice/model/partner'
require 'mf_cloud/invoice/model/department'
require 'mf_cloud/invoice/model/item'
require 'mf_cloud/invoice/model/billing'
require 'mf_cloud/invoice/model/document_status'

require 'mf_cloud/invoice/collection/base'
require 'mf_cloud/invoice/collection/meta_data'
require 'mf_cloud/invoice/collection/partner_collection'
require 'mf_cloud/invoice/collection/department_collection'
require 'mf_cloud/invoice/collection/item_collection'
require 'mf_cloud/invoice/collection/billing_collection'

module MfCloud
  module Invoice
    class Client
      def initialize(options = {}, &block)
        @config = MfCloud::Invoice::Configure.new(options)

        yield @config if block_given?

        @conn = Faraday.new(url: "#{MfCloud::Invoice::API_URL}#{@config.api_version}") do |faraday|
          faraday.request :json

          faraday.response :json

          faraday.adapter Faraday.default_adapter
        end
      end

      def office
        @_office ||= MfCloud::Invoice::Api::Office.new(self)
      end

      def partners
        @_partners ||= MfCloud::Invoice::Api::Partner.new(self)
      end

      def items
        @_items ||= MfCloud::Invoice::Api::Item.new(self)
      end

      def billings
        @_billings ||= MfCloud::Invoice::Api::Billing.new(self)
      end

      def get(path, params = {})
        res = @conn.get do |req|
          req.headers['Authorization'] = "Bearer #{@config.access_token}"
          req.url path, params
        end

        check_response!(res)
        res.body
      end

      def post(path, params = {})
        res = @conn.post do |req|
          req.headers['Authorization'] = "Bearer #{@config.access_token}"
          req.url path
          req.body = params
        end

        check_response!(res)
        res.body
      end

      def put(path, params = {})
        res = @conn.put do |req|
          req.headers['Authorization'] = "Bearer #{@config.access_token}"
          req.url path
          req.body = params
        end

        check_response!(res)
        res.body
      end

      def delete(path, params = {})
        res = @conn.delete do |req|
          req.headers['Authorization'] = "Bearer #{@config.access_token}"
          req.url path, params
        end

        check_response!(res)
      end

      private

      def check_response!(res)
        case res.status
        when 400
          fail MfCloud::Invoice::InvalidRequest, res.body["errors"].first["message"]
        when 401
          fail MfCloud::Invoice::InvalidAccessToken, 'アクセストークンが不正です'
        when 402
          fail MfCloud::Invoice::PaymentRequired, res.body["errors"].first["message"]
        when 404
          fail MfCloud::Invoice::ResourceNotFound, res.body["errors"].first["message"]
        when 422
          fail MfCloud::Invoice::InvalidParameter, res.body["errors"].first["message"]
        when 429
          fail MfCloud::Invoice::RateLimitted, res.body["errors"].first["message"]
        when 500
          if res.body["errors"].nil?
            msg = 'サーバーがメンテナンス中かダウンしている可能性があります。しばらく待って再度お試しください。'
          else
            msg = res.body["errors"].first["message"]
          end

          fail MfCloud::Invoice::InternalServerError, msg
        else
          true
        end
      end
    end
  end
end
