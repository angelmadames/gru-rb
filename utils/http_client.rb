# frozen_string_literal: true

require 'faraday'
require 'faraday/net_http'

def http_client(url, headers)
  Faraday.default_adapter = :net_http

  Faraday.new(
    url: url,
    headers: headers
  )
end
