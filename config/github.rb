# frozen_string_literal: true

require 'dotenv/load'

owner = ENV.fetch('GITHUB_OWNER')
repo  = ENV.fetch('GITHUB_REPO')
token = ENV.fetch('GITHUB_TOKEN')

GITHUB_BASE_API_URL        = 'https://api.github.com'
GITHUB_REPO_ENDPOINT       = "/repos/#{owner}/#{repo}".freeze
GITHUB_REPO_LABEL_ENDPOINT = "#{GITHUB_REPO_ENDPOINT}/labels".freeze

GITHUB_REST_API_HEADERS = {
  Accept:        'application/vnd.github.v3+json',
  Authorization: "token #{token}"
}.freeze
