# frozen_string_literal: true

module Config
  module Repo
    module_function

    def settings
      Config::VALUES['repository']
    end
  end
end
