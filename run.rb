#!/usr/bin/env ruby
# frozen_string_literal: true

require 'dotenv/load'
require 'thor'
require_relative 'config/labels'
require_relative 'config/repository'
require_relative 'src/lib/labels'
require_relative 'src/lib/repository'

class RepositoryUpdater < Thor
  def self.exit_on_failure?
    true
  end

  desc 'add_labels', 'Add default labels to repository'
  def add_labels
    # Delete existing labels
    Labels.delete if ENV.fetch('DELETE_EXISTING_LABELS') == true

    # Add or update labels in config/labels.rb
    Labels.add(LABELS)
  end

  desc 'update_config', 'Update repository settings'
  def update_config
    # Add or update settings in config/repository.rb
    Repository.update(DEFAULT_REPOSITORY_CONFIG)
  end
end

RepositoryUpdater.start
