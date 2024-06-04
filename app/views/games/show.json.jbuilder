# frozen_string_literal: true

# serializer for games index
json.message "Game has been found with id #{@game.id}"
json.extract! @game, :id, :game_type, :rounds, :chance_per_round, :top_scorer_score, :created_at
json.xname "#{@game&.teams&.first&.name} Vs #{@game&.teams&.second&.name}"
json.teams @game.teams do |team|
  json.extract! team, :id, :name, :score, :is_winner
  json.players team.team_players do |player|
    json.extract! player, :id, :score, :is_captain
    json.rounds player.rounds do |round|
      json.extract! round, :id, :score
      json.chances round.chances do |chance|
        json.extract! chance, :id, :score
      end
    end
  end
end
