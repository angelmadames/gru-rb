# frozen_string_literal: true

require 'thor'
require 'dotenv/load'
require_relative '../config/github'
require_relative '../utils/log'
require_relative '../utils/output'

class Labels < Thor
  def self.shared_options
    option(
      :repo,
      :type    => :string,
      :aliases => '-r',
      :desc    => 'Git repository to list existing labels for',
      :default => GitHub.repo_full_name
    )
  end

  desc 'list', 'List labels for the specified repo'
  shared_options
  def list
    rows     = []
    headings = %w[name color]

    GitHub.octokit.labels(options.repo).each do |label|
      rows << [label.name, label.color]
    end

    puts_table("Labels for repo: #{options.repo}", headings, rows)
  end

  desc 'add', 'Add config.yml labels to the specified repo'
  shared_options
  def add
    puts "Adding labels to repo: #{options.repo}"
    existing = existing_labels(options.repo)

    Config::Labels.list.each do |name, color|
      next if existing.include?(name)

      GitHub.octokit.add_label(options.repo, name, color)
      Log.info "Added label: #{name}"
    end

    Log.success 'All labels were successfully added.'
  end

  desc 'remove', 'Removes existing repo labels not in config yaml file'
  shared_options
  def remove
    Log.info "Removing existing labels to repo: #{options.repo}"
    return if existing_labels(options.repo).empty?

    existing_labels(options.repo).each do |name|
      if Config::Labels.list.include? name
        Log.info "Not removed, meant to be added anyway: #{name}"
      else
        GitHub.octokit.delete_label!(options.repo, name)
      end
    end

    Log.success '✅ All labels (not in config) were successfully removed.'
  end

  no_commands do
    def existing_labels(repo = GitHub.repo_full_name)
      Set.new(GitHub.octokit.labels(repo).map(&:name))
    end
  end
end
