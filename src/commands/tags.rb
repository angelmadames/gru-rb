# frozen_string_literal: true

require 'thor'
require 'dotenv/load'
require_relative '../config/github'
require_relative '../utils/log'
require_relative '../utils/output'
require_relative '../options/common'
require_relative '../utils/labels'
require_relative '../utils/tags'

class Tags < Thor
  desc 'list', 'List tags for the specified repo'
  option(*CommonOptions.repo)
  def list
    rows     = []
    headings = %w[tag commit]
    tags     = GitHub.octokit.tags(options.repo)

    tags.each do |tag|
      rows << [tag.name, tag.commit.sha]
    end

    puts_table("Tags for repo: #{options.repo}", headings, rows)
  end

  desc 'count', 'Count tags for the specified repo'
  option(*CommonOptions.repo)
  def count
    count_tags(options.repo)
  end
end
