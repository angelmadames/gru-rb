# frozen_string_literal: true

require 'erb'

def uri_encode(uri)
  ERB::Util.url_encode(uri) if uri.include?(' ')
end
