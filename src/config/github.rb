# frozen_string_literal: true

require 'dotenv/load'
require 'octokit'

module GitHub
  module_function

  OWNER = ENV.fetch('GITHUB_OWNER')
  REPO  = ENV.fetch('GITHUB_REPO')
  TOKEN = ENV.fetch('GITHUB_TOKEN')

  def octokit
    Octokit::Client.new(:access_token => TOKEN)
  end

  def repo_full_name
    "#{OWNER}/#{REPO}"
  end
end
