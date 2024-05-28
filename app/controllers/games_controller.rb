# frozen_string_literal: true

# Controller for Game
class GamesController < ApplicationController
  before_action :permitted_params, only: [:create]

  def create
    game = Game.new(permitted_params)
    if game.validate
      game.save
      render json: { message: 'Game has been created!', data: game }, status: :created
    else
      render json: { message: game.errors.full_messages.to_sentence, data: nil }, status: :unprocessable_entity
    end
  end

  def index
    @games = Game.all
    render
  end

  private

  def permitted_params
    params.require(:games).permit(:game_type,
                                  :rounds,
                                  :chance_per_round,
                                  teams_attributes: [
                                    :name
                                  ])
  end
end
