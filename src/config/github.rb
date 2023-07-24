# frozen_string_literal: true

require 'dotenv/load'
require 'octokit'

module GitHub
  module_function

  def token
    ENV.fetch('GITHUB_TOKEN')
  end

  def octokit
    Octokit::Client.new(:access_token => token)
  end

  def organization
    ENV.fetch('GITHUB_OWNER')
  end

  def current_repo
    ENV.fetch('GITHUB_REPO')
  end

  def current_repo_full_name
    "#{organization}/#{current_repo}"
  end
end
