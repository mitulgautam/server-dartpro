# frozen_string_literal: true

# serializer for games index
json.message 'List of all Games'
json.games @games do |game|
  json.extract! game, :id, :game_type, :rounds, :chance_per_round, :top_scorer_score, :created_at
  json.teams game.teams do |team|
    json.extract! team, :id, :name, :score, :is_winner
    json.players team.team_players do |player|
      json.extract! player, :id, :score, :is_captain
    end
  end
end
