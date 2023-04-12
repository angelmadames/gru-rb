# frozen_string_literal: true

require 'dotenv/load'

module Config
  module Github
    module_function

    OWNER = ENV.fetch('GITHUB_OWNER')
    REPO  = ENV.fetch('GITHUB_REPO')
    TOKEN = ENV.fetch('GITHUB_TOKEN')

    def endpoints
      {
        base:       'https://api.github.com',
        repo:       "/repos/#{OWNER}/#{REPO}",
        repo_label: "/repos/#{OWNER}/#{REPO}/labels"
      }
    end

    def headers
      {
        Accept:        'application/vnd.github.v3+json',
        Authorization: "token #{TOKEN}"
      }
    end
  end
end
