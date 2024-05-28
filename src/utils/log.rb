# frozen_string_literal: true

require 'colorize'

module Log
  module_function

  def success(text)
    puts text.colorize(:light_green)
  end

  def info(text)
    puts text.colorize(:light_blue)
  end

  def warning(text)
    puts text.colorize(:yellow)
  end

  def error(text)
    puts text.colorize(:light_red)
  end
end
