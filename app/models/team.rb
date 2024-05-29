# frozen_string_literal: true

# Model for GameTeam with validations
class Team < ApplicationRecord
  belongs_to :game
  has_many :team_players, dependent: :destroy

  validates_presence_of :name, message: 'must be present of the team.'
  accepts_nested_attributes_for :team_players
end
