# frozen_string_literal: true

require 'dotenv/load'
require 'thor'
require_relative '../config/github'
require_relative 'log'
require_relative 'output'

module Utils
  module Labels
    module_function

    def add(repo = GitHub.current_repo_full_name)
      Log.info "Adding labels to repo: #{repo}"
      default_list.each do |name, color|
        next if existing(repo).include?(name)

        GitHub.octokit.add_label(repo, name, color)
        Log.info "Label added: #{name}"
      end
      Log.success "Labels updated for: #{repo}"
    end

    def delete(repo = GitHub.current_repo_full_name)
      existing(repo).each do |name|
        if default_list.include? name
          Log.info "Not removed, meant to be added anyway: #{name}"
        else
          GitHub.octokit.delete_label!(options.repo, name)
        end
      end
    end

    def existing(repo = GitHub.current_repo_full_name)
      GitHub.octokit.labels(repo).map(&:name)
    end

    def default_list
      Config::Labels.list.freeze
    end

    def default_minus_existing(repo = GitHub.current_repo_full_name)
      existing(repo) + default_list
    end
  end
end
