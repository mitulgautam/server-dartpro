# frozen_string_literal: true

# PlayerController for CRUD
class PlayersController < ApplicationController
  before_action :permitted_params, only: [:create]
  def create
    player = Player.new(permitted_params)
    if player.validate
      player.save
      render json: { message: 'Player has been created!', data: player }, status: :created
    else
      render json: { message: player.errors.full_messages.to_sentence, data: nil }, status: :unprocessable_entity
    end
  end

  def index
    @players = Player.all
    render
  end

  private

  def permitted_params
    params.require(:player).permit(:name, :username)
  end
end
