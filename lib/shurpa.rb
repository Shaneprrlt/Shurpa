require "shurpa/version"
require "shurpa/resource_interface"
require "shurpa/account"
require "shurpa/delivery"

module Shurpa

  ## Shurpa API ##
  @api_version = "api/v1"
  @api_base = "https://app.shurpa.com"

  ## API Connection ##
  class << self
    attr_accessor :api_key, :api_base, :api_version

    def get_connection
      url = self.api_base
      api_version = self.api_version

      Faraday.new(url: "#{url}/#{api_version}") do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end
  end

  ## Error Classes ##
  class ResourceNotCreated < StandardError
  end
  class ResourceNotFound < StandardError
  end
end
