# frozen_string_literal: true

# serializer for games index
json.message "Game has been found with id #{@game.id}"
json.extract! @game, :id, :game_type, :rounds, :chance_per_round, :top_scorer_score, :created_at
json.xname "#{@game&.teams&.first&.name} Vs #{@game&.teams&.second&.name}"
json.teams @game.teams do |team|
  json.extract! team, :id, :name, :score, :is_winner
end
json.extract! @turn_tracker, :current_player_id, :current_team_id
json.current_round_id TeamPlayer.find_by_id(@turn_tracker.current_player_id).current_round
