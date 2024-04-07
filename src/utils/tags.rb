# frozen_string_literal: true

require 'dotenv/load'
require 'thor'
require_relative '../config/github'
require_relative 'log'

def count_tags(repo = GitHub.current_repo_full_name)
  tags = GitHub.octokit.tags(repo)
  Log.info "Total # of tags for '#{repo}': #{tags.size}"
end
