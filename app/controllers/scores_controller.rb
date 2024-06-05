# frozen_string_literal: true

# ScoresController for creating score entries and broadcasting socket data
class ScoresController < ApplicationController
  def update_score
    team_player_id = params[:score][:team_player_id]
    round_num = params[:score][:round]
    score = params[:score][:score]
    team_player = TeamPlayer.find_by(id: team_player_id)
    game_id = team_player.team.game_id

    round = Round.find_or_initialize_by(team_player_id:, current_round: round_num)
    turn_tracker = TurnTracker.find_by(game_id:)
    if round.chances.count < team_player.team.game.chance_per_round
      round.score = round.score + score
      round.game_id = game_id
      round.team_id = team_player.team_id

      chance = round.chances.build
      chance.score = score
      chance.team_player_id = team_player.id

      if round.save
        team_player.team.score += score
        team_player.team.save!
        if round.chances.count >= team_player.team.game.chance_per_round
          turn_order = TurnOrder.find_by(game_id:,
                                         team_id: team_player.team_id,
                                         team_player_id: team_player.id)
          next_turn_order = TurnOrder.where(game_id:,
                                            team_id: team_player.team_id)

          turn_tracker.current_player_id = turn_tracker.next_player_id
          turn_tracker.current_team_id = turn_tracker.next_team_id
          turn_tracker.next_player_id =
            next_turn_order.order(id: :asc) # reset back to first player with mod
                           .find_by(turn_order: ((turn_order.turn_order % team_player&.team&.team_players&.count) + 1))
                           .team_player_id
          turn_tracker.next_team_id =
            next_turn_order.order(id: :asc) # reset back to first player with mod
                           .find_by(turn_order: ((turn_order.turn_order % team_player&.team&.team_players&.count) + 1))
                           .team_id
          turn_tracker.save!
        end
        render json: { message: 'Voilla, It\'s done!', data: {
          next_player_id: turn_tracker.current_player_id,
          next_team_id: turn_tracker.current_team_id,
          game: team_player.team.game
        } }, status: :ok
      else
        render json: { message: round.errors.full_messages.to_sentence,
                       data: { next_player_id: turn_tracker.current_player_id,
                               next_team_id: turn_tracker.current_team_id } },
               status: :unprocessable_entity
      end
    else
      render json: { message: 'All chances has been taken already!', data: {
        next_player_id: turn_tracker.current_player_id,
        next_team_id: turn_tracker.current_team_id,
        game: team_player.team.game
      } }, status: :unprocessable_entity
    end
  end
end
