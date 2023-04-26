# frozen_string_literal: true

require 'json'
require_relative 'output'

module Repository
  module_function

  def client
    Http.client(Config::Github.endpoints[:base], Config::Github.headers)
  end

  def update(settings)
    body = settings.to_json

    puts '📘 Repository settings to be applied are :'
    puts pretty_print_json(body)

    res = client.patch(Config::Github.endpoints[:repo], body)

    Http.handle_response(res, '✅ All default settings were applied!')
  end
end
