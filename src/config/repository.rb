# frozen_string_literal: true

module Config
  module Repository
    module_function

    def settings
      Config::VALUES['repository']
    end
  end
end
