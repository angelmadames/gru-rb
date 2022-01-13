# frozen_string_literal: true

require 'dotenv/load'

owner = ENV['GITHUB_OWNER']
repo = ENV['GITHUB_REPO']
token = ENV['GITHUB_TOKEN']

GITHUB_BASE_API_URL = 'https://api.github.com'
GITHUB_REPO_LABEL_ENDPOINT = "/repos/#{owner}/#{repo}/labels"

GITHUB_REST_API_HEADERS = {
  Accept: 'application/vnd.github.v3+json',
  Authorization: "token #{token}"
}
