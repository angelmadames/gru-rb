# frozen_string_literal: true

require 'dotenv/load'
require 'thor'
require_relative '../config/github'
require_relative 'log'

module Utils
  module Tags
    module_function

    def delete(tags, repo = GitHub.current_repo_full_name)
      tags.each do |tag|
        puts "Deleting tag: #{tag.name}..."
        GitHub.octokit.delete_ref(repo, tag.name)
        puts "Tag #{tag.name} deleted successfully."
      end
    end

    def list(tags, table_title = 'Tags for repo:')
      headings = %w[tag commit]

      rows = tags.map do |tag|
        [tag.name, tag.commit.sha]
      end

      puts_table("#{table_title} #{options.repo}", headings, rows)
    end

    def count(repo = GitHub.current_repo_full_name)
      tags = GitHub.octokit.tags(repo)
      Log.info "Total # of tags for '#{repo}': #{tags.size}"
    end

    def after_limit(repo = GitHub.current_repo_full_name, limit = 100)
      tags = GitHub.octokit.tags(repo)
      tags.drop(limit)
    end

    def list_after_limit(repo = GitHub.current_repo_full_name, limit = 100)
      puts "Tags count exceeds specified limit (#{limit})!"
      puts list(after_limit(repo, limit), 'Older tags for repo')
    end
  end
end
