#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require_relative 'config/github'
require_relative 'utils/http_client'

labels = Array.new

client = http_client(GITHUB_BASE_API_URL, GITHUB_REST_API_HEADERS)
res = client.get(GITHUB_REPO_LABEL_ENDPOINT)

data = JSON.parse(res.body)
data.each do |label|
  labels.push(label['name'])
end

# @WIP.
