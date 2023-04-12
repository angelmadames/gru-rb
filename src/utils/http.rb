# frozen_string_literal: true

require 'faraday'
require 'faraday/net_http'

module Http
  module_function

  def client(url, headers)
    Faraday.default_adapter = :net_http

    Faraday.new(
      url:     url,
      headers: headers
    )
  end

  def response_handle(res, msg)
    if res.status == 200
      puts msg
    else
      puts 'Error:'
      puts res.reason_phrase
    end
  end
end
