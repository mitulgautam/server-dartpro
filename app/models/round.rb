# frozen_string_literal: true

# Round class and its validations
class Round < ApplicationRecord
  belongs_to :game
  belongs_to :team
  belongs_to :player

  validates :current_round, presence: true,
                            uniqueness: { scope: %i[game team player] },
                            numericality: { greater_than: 0 }
  validates :team, :game, :player, presence: true
end
