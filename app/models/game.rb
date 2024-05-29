# frozen_string_literal: true

# Model for Game with validations
class Game < ApplicationRecord
  has_many :teams, dependent: :destroy

  validates :game_type, :rounds, :chance_per_round, presence: true
  validates :rounds, :chance_per_round, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :teams

  after_create :create_game_rounds

  def create_game_rounds
    teams.each do |team|
      team.team_players.each do |player|
        (1..rounds).each do |i|
          round = Round.new
          round.score = 0
          round.current_round = i
          round.game_id = id
          round.team_id = team.id
          round.team_player_id = player.id
          (1..chance_per_round).each do
            round.chances.build(score: 0, team_player_id: player.id)
          end
          round.save if round.validate
        end
      end
    end
  end
end
