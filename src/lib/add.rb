# frozen_string_literal: true

require 'json'
require_relative '../../config/github'
require_relative '../../config/labels'
require_relative '../utils/http_client'

module Labels
  module_function

  def add(labels)
    client = http_client(GITHUB_BASE_API_URL, GITHUB_REST_API_HEADERS)

    labels.each do |name, color|
      body = {
        name:  name,
        color: color
      }.to_json

      client.post(GITHUB_REPO_LABEL_ENDPOINT, body)
      puts "Added label #{name} successfully!"
    end
  end
end
