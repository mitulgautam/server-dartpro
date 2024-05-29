# frozen_string_literal: true

# ScoresController for creating score entries and broadcasting socket data
class ScoresController < ApplicationController
  def create_round
    round = Round.new
    if round.validate
      round.save
      render json: { message: 'Round has been created!', data: round }, status: :created
    else
      render json: { message: round.errors.full_messages.to_sentence, data: nil }, status: :unprocessable_entity
    end
  end

  private

  def round_params
    params.require(:round).permit(:game_id, :team_id, :player_id)
  end
end
