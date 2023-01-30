# frozen_string_literal: true

require 'json'
require_relative '../../config/github'
require_relative '../../config/repository'
require_relative '../utils/http_client'

module Repository
  module_function

  def update(settings)
    client = http_client(GITHUB_BASE_API_URL, GITHUB_REST_API_HEADERS)

    body = settings.to_json

    client.patch(GITHUB_REPO_ENDPOINT, body)

    puts "All default settings for repo '#{ENV.fetch('GITHUB_REPO')}' were applied!"
  end
end
