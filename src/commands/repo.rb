# frozen_string_literal: true

require 'thor'
require 'dotenv/load'
require_relative '../utils/output'

class Repo < Thor
  def self.shared_options
    option(
      :repo,
      :type    => :string,
      :aliases => '-r',
      :desc    => 'Git repository to list existing labels for',
      :default => GitHub.repo_full_name
    )
  end

  desc 'update-settings', 'Update repository settings using default config'
  shared_options
  def update_settings
    puts "Updating settings for repo: #{options.repo}"
    puts 'Settings to be applied:'
    list_default_settings

    GitHub.octokit.edit_repository(options.repo, Config::Repository.settings)

    puts '✅ All default settings were applied!'
  end

  no_commands do
    def list_default_settings
      rows     = []
      headings = %w[setting value]

      Config::Repository.settings.each do |setting, value|
        rows << [setting, value]
      end

      puts_table('Default repo settings', headings, rows)
    end
  end
end
