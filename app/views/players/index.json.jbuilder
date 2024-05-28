# frozen_string_literal: true

# serializer for player index
json.message 'List of all players with username.'
json.players @players do |p|
  json.extract! p, :id, :name, :username
end
