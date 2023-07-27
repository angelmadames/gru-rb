# frozen_string_literal: true

require 'thor'

module CommonOptions
  module_function

  def repo
    [:repo, {
      :type    => :string,
      :aliases => '-r',
      :desc    => 'Git repository to list existing labels for',
      :default => GitHub.current_repo_full_name
    }]
  end

  def org
    [:org, {
      :type    => :string,
      :aliases => '-o',
      :desc    => 'GitHub organization to apply settings to',
      :default => GitHub.organization
    }]
  end
end
