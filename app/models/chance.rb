# frozen_string_literal: true

# Chance class and its validations
class Chance < ApplicationRecord
  belongs_to :round
  belongs_to :team_player

  validates :score, presence: true
end
