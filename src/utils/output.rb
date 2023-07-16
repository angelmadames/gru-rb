# frozen_string_literal: true

require 'json'
require 'terminal-table'

def puts_table(title, headings, rows)
  puts Terminal::Table.new(
    :title    => title,
    :headings => headings,
    :rows     => rows
  )
end

def pretty_print_json(text)
  puts JSON.pretty_generate(JSON.parse(text))
end
