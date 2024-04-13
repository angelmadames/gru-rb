# frozen_string_literal: true

require 'thor'
require 'dotenv/load'
require_relative '../config/github'
require_relative '../utils/log'
require_relative '../utils/output'
require_relative '../options/common'
require_relative '../utils/labels'

class Labels < Thor
  desc 'list', 'List labels for the specified repo'
  option(*CommonOptions.repo)
  def list
    headings = %w[name color]
    labels   = GitHub.octokit.labels(options.repo)

    rows = labels.map do |label|
      [label.name, label.color]
    end

    puts_table("Labels for repo: #{options.repo}", headings, rows)
  end

  desc 'update', 'Add labels in config.yml to the specified repo'
  option(*CommonOptions.repo)
  def update
    add_labels(options.repo)
  end

  desc 'update-all', 'Add labels in config.yml to repos in specified org'
  option(*CommonOptions.org)
  def update_all
    puts "Updating labels for all repos in org: #{options.org}"
    GitHub.list_all_repositories_from_org.each { |repo| add_labels(repo) }
    Log.success 'All labels were successfully updated for all repositories.'
  end

  desc 'remove', 'Removes existing repo labels not in config yaml file'
  option(*CommonOptions.repo)
  def remove
    Log.info "Removing existing labels to repo: #{options.repo}"
    return if existing_labels_in_repo(options.repo).empty?

    delete_labels(options.repo)
    Log.success '✅ All labels (not in config) were successfully removed.'
  end
end
