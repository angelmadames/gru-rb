# frozen_string_literal: true

require 'json'

module Labels
  module_function

  def client
    Http.client(Config::Github.endpoints[:base], Config::Github.headers)
  end

  def existing
    res = client.get(Config::Github.endpoints[:repo_label])
    JSON.parse(res.body)
  end

  def add(labels)
    puts '➕ Adding labels…'

    existing_label_names = existing.map { |label| label['name'] }

    labels.each do |name, color|
      if existing_label_names.include? name
        puts "➡️ Already added: #{name}"
        next
      end

      body = {
        name:  name,
        color: color
      }.to_json

      res = client.post(Config::Github.endpoints[:repo_label], body)
      Http.handle_response(res, '✅ Added', name)
    end
  end

  # rubocop:disable Metrics/AbcSize
  def remove
    puts '🗑️ Removing existing labels…'

    if existing.empty?
      puts 'ℹ️ Repository has no labels to remove.'
      return
    end

    labels_to_remove = existing.map { |label| label['name'] }

    labels_to_remove.each do |name|
      if Config::Labels.colors.include? name
        puts "➡️ Not removed, meant to be added: #{name}"
      else
        encoded_label = Http.uri_encode(name)

        res = client.delete("#{Config::Github.endpoints[:repo_label]}/#{encoded_label}")
        Http.handle_response(res, '✅ Removed', name)
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
end
