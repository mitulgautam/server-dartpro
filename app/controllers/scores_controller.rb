# frozen_string_literal: true

# ScoresController for creating score entries and broadcasting socket data
class ScoresController < ApplicationController
  def update_score
    team_player_id = params[:score][:team_player_id]
    round_num = params[:score][:round]
    # chance_num = params[:score][:chance]
    score = params[:score][:score]
    team_player = TeamPlayer.find_by(id: team_player_id)

    round = Round.new
    round.score = round.score + score
    round.current_round = round_num
    round.game_id = team_player.team.game_id
    round.team_id = team_player.team_id
    round.team_player_id = team_player.id

    chance = round.chances.build
    chance.score = score
    chance.team_player_id = team_player.id

    if round.save
      if round.chances.count == team_player.team.game.chance_per_round
        turn_tracker = TurnTracker.find_by(game_id: team_player.team.game_id)
        turn_order = TurnOrder.find_by(game_id: team_player.team.game_id,
                                       team_id: team_player.team_id,
                                       team_player_id: team_player.id)

        next_turn_order = TurnOrder.where(game_id: team_player.team.game_id,
                                          team_id: team_player.team_id)

        turn_tracker.current_player_id = turn_tracker.next_player_id
        turn_tracker.current_team_id = turn_tracker.next_team_id
        turn_tracker.next_player_id =
          next_turn_order.order(id: :asc) # reset back to first player with mod
                         .find_by(turn_order: ((turn_order.turn_order % team_player&.team&.game&.chance_per_round) + 1))
                         .team_player_id
        turn_tracker.next_team_id =
          next_turn_order.order(id: :asc) # reset back to first player with mod
                         .find_by(turn_order: ((turn_order.turn_order % team_player&.team&.game&.chance_per_round) + 1))
                         .team_id
        if turn_tracker.save
          render json: { message: 'Voilla, It\'s done!', data: {
            next_player_id:,
            next_team_id:,
            game: team_player.team.game
          } }, status: :ok
        else
          render json: { message: turn_tracker.errors.full_messages.to_sentence, data: nil },
                 status: :unprocessable_entity
        end
      end
      render json: { message: 'Voilla, It\'s done!', data: {
        game: team_player.team.game
      } }, status: :ok
    else
      render json: { message: round.errors.full_messages.to_sentence, data: nil }, status: :unprocessable_entity
    end
  end
end
