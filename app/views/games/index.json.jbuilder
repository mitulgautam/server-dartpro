# frozen_string_literal: true

# serializer for games index
json.message 'List of all Games'
json.games @games do |game|
  json.extract! game, :id, :game_type, :rounds, :chance_per_round, :top_scorer_score, :created_at
end
