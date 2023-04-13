#!/usr/bin/env ruby
# frozen_string_literal: true

Dir['src/**/*.rb'].each { |file| require_relative file }

def run
  puts "Updating '#{Config::Github::REPO}' repository"
  puts

  Labels.delete if Config::Labels.delete_existing?

  Labels.add(Config::Labels.colors)

  Repository.update(Config::Repository.settings)
end

run if $PROGRAM_NAME == __FILE__
