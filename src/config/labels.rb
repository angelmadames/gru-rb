# frozen_string_literal: true

module Config
  module Labels
    module_function

    def list
      Config::VALUES['labels']
    end

    def names
      list.keys
    end
  end
end
