module MfCloud
  module Invoice
    # for handling api error
    class InvalidRequest < StandardError; end
    class InvalidAccessToken < StandardError; end
    class PaymentRequired < StandardError; end
    class ResourceNotFound < StandardError; end
    class InvalidParameter < StandardError; end
    class RateLimitted < StandardError; end
    class InternalServerError < StandardError; end

    # for client error
    class MethodNotAllowed < StandardError; end
  end
end
