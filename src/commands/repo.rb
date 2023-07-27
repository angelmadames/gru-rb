# frozen_string_literal: true

require 'thor'
require 'dotenv/load'
require_relative '../utils/output'
require_relative '../options/common'

class Repo < Thor
  desc 'update', 'Update repository settings using default config'
  option(*CommonOptions.repo)
  def update
    Log.info "Updating settings for repo: #{options.repo}"
    list_default_settings

    GitHub.octokit.edit_repository(options.repo, Config::Repository.settings)

    Log.success 'All default settings were applied!'
  end

  desc 'update-all', 'Update settings for all repositories in current organization'
  option(*CommonOptions.org)
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
  option(*CommonOptions.repo)
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
      client               = GitHub.octokit
      client.auto_paginate = true
      client.organization_repositories(GitHub.organization)
            .reject(&:archived)
            .map(&:full_name)
    end
  end
end
