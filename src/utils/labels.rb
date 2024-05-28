# frozen_string_literal: true

require 'dotenv/load'
require 'thor'
require_relative '../config/github'
require_relative 'log'
require_relative 'output'

module Utils::Labels
  module_function

  def add(repo = GitHub.current_repo_full_name)
    Log.info "Adding labels to repo: #{repo}"

    existing_labels = existing_labels_from_repo(repo)
    labels_to_add   = default_labels_list.except(*existing_labels)

    labels_to_add.each do |name, color|
      GitHub.octokit.add_label(repo, name, color)
      Log.info "Label added: #{name}"
    end

    Log.success "Labels updated for: #{repo}"
  end

  def delete(repo = GitHub.current_repo_full_name)
    existing_labels_from_repo(repo).each do |name|
      if default_labels_list.include? name
        Log.info "Not removed, meant to be added anyway: #{name}"
      else
        GitHub.octokit.delete_label!(options.repo, name)
      end
    end
  end

  def existing_labels_from_repo(repo = GitHub.current_repo_full_name)
    GitHub.octokit.labels(repo).map(&:name)
  end

  def default_labels_list
    Config::Labels.list.freeze
  end

  def default_minus_existing(repo = GitHub.current_repo_full_name)
    existing_labels_from_repo(repo) + default_labels_list
  end
end
