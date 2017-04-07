require "shurpa/version"
require "faraday"
require "json"

module Shurpa
  module ResourceInterface

    # Currently, the Shurpa API only supports
    # creating and reading resources, so update
    # and destroy are not necessary as of March 2017

    def createResource(url, params={})
      ## Configure Connection ##
      conn = Shurpa.get_connection
      api_key = Shurpa.api_key

      ## Perform the Request ##
      resp = conn.post do |req|
        req.url url
        req.headers["Authorization"] = "Bearer #{api_key}"
        req.headers["Content-Type"] = "application/json"
        req.body = params.to_json
      end

      ## Return Response Body ##
      JSON.parse(resp.body)
    end

    def findResource(url, params={})
      ## Configure Connection ##
      conn = Shurpa.get_connection
      api_key = Shurpa.api_key

      ## Perform the Request ##
      resp = conn.get do |req|
        req.url url
        req.headers["Authorization"] = "Bearer #{api_key}"
        req.headers["Content-Type"] = "application/json"
      end

      ## Return Response as Object ##
      JSON.parse(resp.body)
    end

  end
end
