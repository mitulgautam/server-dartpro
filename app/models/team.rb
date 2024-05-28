# frozen_string_literal: true

# Model for GameTeam with validations
class Team < ApplicationRecord
  belongs_to :game

  validates_presence_of :name, message: 'must be present of the team.'
end
