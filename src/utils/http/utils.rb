# frozen_string_literal: true

require 'erb'
require 'json'

module Http
  module_function

  def uri_encode(uri)
    if uri.include?(' ')
      ERB::Util.url_encode(uri)
    else
      uri
    end
  end

  def response_decode(res)
    JSON.parse(res.env.response_body)['errors'].first
  end

  def response_errors(res)
    response_decode(res)['code']
  end
end
