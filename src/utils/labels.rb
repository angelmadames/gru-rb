# frozen_string_literal: true

require 'dotenv/load'
require 'thor'
require_relative '../config/github'
require_relative 'log'
require_relative 'output'

def add_labels(repo = GitHub.current_repo_full_name)
  Log.info "Adding labels to repo: #{repo}"
  default_labels_list.each do |name, color|
    next if existing_labels_in_repo(repo).include?(name)

    GitHub.octokit.add_label(repo, name, color)
    Log.info "Label added: #{name}"
  end
  Log.success "Labels updated for: #{repo}"
end

def delete_labels(repo = GitHub.current_repo_full_name)
  existing_labels_in_repo(repo).each do |name|
    if default_labels_list.include? name
      Log.info "Not removed, meant to be added anyway: #{name}"
    else
      GitHub.octokit.delete_label!(options.repo, name)
    end
  end
end

def existing_labels_in_repo(repo = GitHub.current_repo_full_name)
  GitHub.octokit.labels(repo).map(&:name)
end

def default_labels_list
  Config::Labels.list.freeze
end

def default_labels_minus_existing(repo = GitHub.current_repo_full_name)
  existing_labels_in_repo(repo) + default_labels_list
end
