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

  def show
    @game = Game.find_by(id: params[:id])
    if @game.present?
      render
    else
      render json: { message: "Unable to find with id #{params[:id]}", data: nil }, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:game).permit(:game_type,
                                 :rounds,
                                 :chance_per_round,
                                 teams_attributes: [
                                   :name,
                                   { team_players_attributes: %i[
                                     player_id is_captain
                                   ] }
                                 ])
  end
end
