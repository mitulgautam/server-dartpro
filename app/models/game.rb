# frozen_string_literal: true

# Model for Game with validations
class Game < ApplicationRecord
  has_many :teams

  validates :game_type, :rounds, :chance_per_round, presence: true
  validates :rounds, :chance_per_round, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :teams
end
