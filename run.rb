#!/usr/bin/env ruby
# frozen_string_literal: true

require 'thor'
Dir['src/**/*.rb'].each { |file| require_relative file }

class RepositoryUpdater < Thor
  def self.exit_on_failure?
    true
  end

  desc 'remove-labels', 'Removes all labels not in config.yml'
  def remove_labels
    Labels.remove
  end

  desc 'add-labels', 'Add labels to repository'
  method_option :remove_existing,
                :type    => :boolean,
                :default => false,
                :aliases => '-d',
                :desc    => 'Remove labels not in config.yml'
  def add_labels
    Labels.remove if options[:delete_existing]
    Labels.add(Config::Labels.colors)
  end

  desc 'update-settings', 'Updates repository settings'
  def update_settings
    Repository.update(Config::Repository.settings)
  end
end

RepositoryUpdater.start if $PROGRAM_NAME == __FILE__
