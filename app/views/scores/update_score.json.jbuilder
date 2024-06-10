# frozen_string_literal: true

# serializer for games index
json.message 'Voilla, It\'s done!'
json.data do
  json.next_player_id @turn_tracker&.current_player_id
  json.next_team_id @turn_tracker&.current_team_id
  json.next_player_name @team_player&.player&.name
  json.teams @game&.teams&.order(id: :asc) do |team|
    json.extract! team, :id, :name, :score, :is_winner
    json.players team.team_players.order(id: :asc) do |tp|
      json.extract! tp, :id, :score
      json.name tp&.player&.name
      json.last_scores tp&.rounds&.last&.chances&.pluck(:score) || []
    end
  end
  json.current_round @team_player&.current_round
end
