# frozen_string_literal: true

require 'thor'
require 'dotenv/load'
require_relative '../config/github'
require_relative '../utils/log'
require_relative '../utils/output'
require_relative '../options/common'

class Labels < Thor
  desc 'list', 'List labels for the specified repo'
  option(*CommonOptions.repo)
  def list
    rows     = []
    headings = %w[name color]
    labels   = GitHub.octokit.labels(options.repo)

    labels.each do |label|
      rows << [label.name, label.color]
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

  # rubocop:disable Metrics/BlockLength
  no_commands do
    def add_labels(repo = GitHub.current_repo_full_name)
      Log.info "Adding labels to repo: #{repo}"
      default_labels_list.each do |name, color|
        next if existing_labels_in_repo(repo).include?(name)

        GitHub.octokit.add_label(repo, name, color)
        Log.info "Label added: #{name}"
      end
      Log.success "Labels updated for: #{repo}"
    end

    def delete_labels(repo = GitHub.current_repo_full_name)
      existing_labels_in_repo(repo).each do |name|
        if default_labels_list.include? name
          Log.info "Not removed, meant to be added anyway: #{name}"
        else
          GitHub.octokit.delete_label!(options.repo, name)
        end
      end
    end

    def existing_labels_in_repo(repo = GitHub.current_repo_full_name)
      GitHub.octokit.labels(repo).map(&:name)
    end

    def default_labels_list
      Config::Labels.list.freeze
    end

    def default_labels_minus_existing(repo = GitHub.current_repo_full_name)
      existing_labels_in_repo(repo) + default_labels_list
    end
  end
  # rubocop:enable Metrics/BlockLength
end
