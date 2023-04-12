# frozen_string_literal: true

require 'json'

module Repository
  module_function

  def client
    Http.client(Config::Github.endpoints[:base], Config::Github.headers)
  end

  def update(settings)
    body = settings.to_json

    res = client.patch(Config::Github.endpoints[:repo], body)

    Http.response_handle(res, 'All default settings were applied!')
  end
end
