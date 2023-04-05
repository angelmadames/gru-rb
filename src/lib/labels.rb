# frozen_string_literal: true

require 'json'

module Labels
  module_function

  def client
    Http.client(Config::Github.endpoints[:base], Config::Github.headers)
  end

  def add(labels)
    labels.each do |name, color|
      body = {
        name:  name,
        color: color
      }.to_json

      res = client.post(Config::Github.endpoints[:repo_label], body)
      Http.handle_response(res, "Added label: #{name}")
    end

    Http.handle_response(res, 'All labels were updated!')
  end

  def delete
    res    = client.get(Config::Github.endpoints[:repo_label])
    labels = JSON.parse(res.body)

    labels_to_delete = labels.map { |label| label['name'] }

    labels_to_delete.each do |label|
      encoded_label = uri_encode(label)

      res = client.delete("#{Config::Github.endpoints[:repo_label]}/#{encoded_label}")
      Http.handle_response(res, "Removed label: #{label}")
    end

    Http.handle_response(res, 'All existing labels were deleted!')
  end
end
