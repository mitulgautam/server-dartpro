# frozen_string_literal: true

# Model for GameTeams and its validations
class TeamPlayer < ApplicationRecord
  belongs_to :team
  belongs_to :player

  validates_presence_of :team, :player
  has_many :rounds, dependent: :destroy

  def current_round
    x_current_round = rounds.maximum(:current_round)
    chance_count = rounds.order(created_at: :desc).first&.chances&.count
    if chance_count == team.game.chance_per_round
      x_current_round + 1
    elsif x_current_round
      x_current_round
    else
      1
    end
  end
end
