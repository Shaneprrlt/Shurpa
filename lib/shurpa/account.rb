require "shurpa/version"
require "faraday"
require "json"
require "hashie"

module Shurpa
  class Account
    extend Shurpa::ResourceInterface

    def self.load
      account = Hashie.symbolize_keys self.findResource('me', {})
      account
    end

  end
end
