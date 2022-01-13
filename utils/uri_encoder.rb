require 'erb'

def uri_encode(uri)
  uri = ERB::Util.url_encode(uri) if uri.include?(' ')

  return uri
end
