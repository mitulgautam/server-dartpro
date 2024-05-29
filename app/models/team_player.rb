# frozen_string_literal: true

# Model for GameTeams and its validations
class TeamPlayer < ApplicationRecord
  belongs_to :team
  belongs_to :player

  validates_presence_of :team, :player
  has_many :rounds, dependent: :destroy
end
