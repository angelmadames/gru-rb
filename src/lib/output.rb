# frozen_string_literal: true

def pretty_print_json(text)
  puts JSON.pretty_generate(JSON.parse(text))
end
