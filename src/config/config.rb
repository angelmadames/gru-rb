# frozen_string_literal: true

require 'yaml'

module Config
  CONFIG_FILE = File.join('config.yml')
  VALUES      = YAML.safe_load_file(File.read(CONFIG_FILE))
end
