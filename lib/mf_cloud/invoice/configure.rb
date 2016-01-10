module MfCloud
  module Invoice
    class Configure
      attr_accessor :client_id, :client_secret, :access_token
      attr_reader :api_version

      def initialize(options = {})
        @client_id     = options[:client_id]
        @client_secret = options[:client_secret]
        @access_token  = options[:access_token]
        @api_version   = :v1
      end
    end
  end
end
