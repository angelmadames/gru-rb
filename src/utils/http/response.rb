# frozen_string_literal: true

module Http
  module_function

  def handle_response(res, msg, type = nil)
    case res.status
    when 200, 201, 204
      if type
        puts "#{msg}: #{type}"
      else
        puts msg
      end
    when 422
      puts "Already exists: #{type}" if response_errors(res) == 'already_exists'
    else
      puts "Error: #{res.reason_phrase}"
    end
  end
end
