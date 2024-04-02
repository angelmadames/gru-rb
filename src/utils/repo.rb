# frozen_string_literal: true

require 'thor'
require 'dotenv/load'
require_relative 'output'
require_relative '../config/repository'

def list_default_settings
  rows     = []
  headings = %w[setting value]

  Config::Repository.settings.each do |setting, value|
    rows << [setting, value]
  end

  Log.info 'Settings to be applied:'
  puts_table('Default repo settings', headings, rows)
end
