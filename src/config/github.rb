# frozen_string_literal: true

require 'dotenv/load'
require 'octokit'

module GitHub
  module_function

  def token
    ENV.fetch('GITHUB_TOKEN')
  end

  def octokit
    client               = Octokit::Client.new(:access_token => token)
    client.auto_paginate = true
    client
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

  def list_all_repositories_from_org
    octokit
      .organization_repositories(GitHub.organization)
      .reject(&:archived)
      .map(&:full_name)
  end
end
