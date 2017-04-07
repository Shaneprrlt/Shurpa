require "shurpa/version"
require "faraday"
require "json"
require "hashie"

module Shurpa
  class Delivery
    extend Shurpa::ResourceInterface

    def self.create(params={})
      delivery = Hashie.symbolize_keys self.createResource("deliveries", params)
      return delivery[:delivery] unless delivery[:delivery].nil?
      return delivery
    end

    def self.find(id, params={})
      delivery = Hashie.symbolize_keys self.findResource("deliveries/#{id}", params)

      return delivery[:delivery] unless delivery[:delivery].nil?
      return delivery
    end

  end
end
