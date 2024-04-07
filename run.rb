#!/usr/bin/env ruby
# frozen_string_literal: true

require 'thor'
Dir['src/**/*.rb'].each { |file| require_relative file }

class RepositoryUpdater < Thor
  def self.exit_on_failure?
    true
  end

  desc 'labels', 'Manage labels for a repository'
  subcommand 'labels', Labels

  desc 'repo', 'Manage repository settings'
  subcommand 'repo', Repo

  desc 'tags', 'Manage tags for a repository'
  subcommand 'tags', Tags
end

RepositoryUpdater.start if $PROGRAM_NAME == __FILE__
