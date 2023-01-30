#!/usr/bin/env ruby
# frozen_string_literal: true

require 'dotenv/load'
require_relative 'config/labels'
require_relative 'config/repository'
require_relative 'src/lib/labels'
require_relative 'src/lib/repository'

def run
  # Delete existing labels
  Labels.delete if ENV.fetch('DELETE_EXISTING_LABELS') == true

  # Add or update labels in config/labels.rb
  Labels.add(LABELS)

  # Add or update settings in config/repository.rb
  Repository.update(DEFAULT_REPOSITORY_CONFIG)
end

run if $PROGRAM_NAME == __FILE__
