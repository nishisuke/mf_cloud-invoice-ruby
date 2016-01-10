module MfCloud
  module Invoice
    API_URL = 'https://invoice.moneyforward.com/api/'
  end
end

require "mf_cloud/invoice/version"
require "mf_cloud/invoice/errors"
require "mf_cloud/invoice/client"
require "mf_cloud/invoice/configure"
