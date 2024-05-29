# frozen_string_literal: true

# Round class and its validations
class Round < ApplicationRecord
  belongs_to :game
  belongs_to :team
  belongs_to :team_player

  has_many :chances, dependent: :destroy

  validates :current_round, presence: true,
                            uniqueness: { scope: %i[game team team_player] },
                            numericality: { greater_than: 0 }
  validates :team, :game, :team_player, presence: true
end
