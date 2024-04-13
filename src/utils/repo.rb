# frozen_string_literal: true

require 'thor'
require 'dotenv/load'
require_relative 'output'
require_relative '../config/repo'

module Utils
  module Repo
    module_function

    def list_default_settings
      headings = %w[setting value]

      rows = Config::Repo.settings.map do |setting, value|
        [setting, value]
      end

      Log.info 'Settings to be applied:'
      puts_table('Default repo settings', headings, rows)
    end
  end
end
