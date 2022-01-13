#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require_relative 'config/github'
require_relative 'config/labels'
require_relative 'utils/http_client'
require_relative 'utils/uri_encoder'

labels_to_delete = []

client = http_client(GITHUB_BASE_API_URL, GITHUB_REST_API_HEADERS)
res = client.get(GITHUB_REPO_LABEL_ENDPOINT)

data = JSON.parse(res.body)
data.each do |label|
  labels_to_delete.push(label['name'])
end

labels_to_delete.each do |label|
  encoded_label = uri_encode(label)

  res = client.delete("#{GITHUB_REPO_LABEL_ENDPOINT}/#{encoded_label}")
  puts "Removed label #{label} successfully!"
end

LABELS.each do |name, color|
  body = {
    name: name,
    color: color
  }.to_json

  res = client.post(GITHUB_REPO_LABEL_ENDPOINT, body)
  puts "Added label #{name} successfully!"
end
