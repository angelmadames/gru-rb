#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'config/labels'
require_relative 'src/lib/delete'
require_relative 'src/lib/add'

def run
  # Delete existing labels
  Labels.delete

  # Add new labels set in LABELS (config/labels.rb)
  Labels.add(LABELS)
end

run if $PROGRAM_NAME == __FILE__
