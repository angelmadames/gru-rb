# frozen_string_literal: true

require 'thor'
require 'dotenv/load'
require_relative '../utils/output'

class Repo < Thor
  def self.repo_option
    option(
      :repo,
      :type    => :string,
      :aliases => '-r',
      :desc    => 'Git repository to list existing labels for',
      :default => GitHub.current_repo_full_name
    )
  end

  def self.organization_option
    option(
      :org,
      :type    => :string,
      :aliases => '-o',
      :desc    => 'GitHub organization to apply settings to',
      :default => GitHub.organization
    )
  end

  desc 'update', 'Update repository settings using default config'
  repo_option
  def update
    Log.info "Updating settings for repo: #{options.repo}"
    list_default_settings

    GitHub.octokit.edit_repository(options.repo, Config::Repository.settings)

    Log.success 'All default settings were applied!'
  end

  desc 'update-all', 'Update settings for all repositories in current organization'
  organization_option
  def update_all
    Log.info "Updating settings for org: #{options.org}"
    list_default_settings

    list_all_repositories_from_org.each do |repo|
      GitHub.octokit.edit_repository(
        repo,
        Config::Repository.settings.merge({ 'name' => repo })
      )
      Log.success "Repo #{repo} updated successfully."
    end

    Log.success 'All default settings were applied!'
  end

  desc 'enable-vulnerability-alerts', 'Enable vulnerability alerts'
  repo_option
  def enable_vulnerability_alerts
    Log.info "Enable vulnerability alerts for repo: #{options.repo}"
    GitHub.octokit.enable_vulnerability_alerts(options.repo)
    Log.success 'Vulnerability alerts were enabled!'
  end

  no_commands do
    def list_default_settings
      rows     = []
      headings = %w[setting value]

      Config::Repository.settings.each do |setting, value|
        rows << [setting, value]
      end

      Log.info 'Settings to be applied:'
      puts_table('Default repo settings', headings, rows)
    end

    def list_all_repositories_from_org
      client = GitHub.octokit
      client.auto_paginate = true
      client.organization_repositories(GitHub.organization)
            .reject(&:archived)
            .map(&:full_name)
    end
  end
end
