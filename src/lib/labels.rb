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
      puts "Added label: #{name}"
    end
  end

  def delete
    client = http_client(GITHUB_BASE_API_URL, GITHUB_REST_API_HEADERS)
    res    = client.get(GITHUB_REPO_LABEL_ENDPOINT)
    labels = JSON.parse(res.body)

    labels_to_delete = labels.map { |label| label['name'] }

    labels_to_delete.each do |label|
      encoded_label = uri_encode(label)

      res = client.delete("#{GITHUB_REPO_LABEL_ENDPOINT}/#{encoded_label}")
      puts "Removed label: #{label}"
    end
  end
end
