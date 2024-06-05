class TurnOrder < ApplicationRecord
  belongs_to :game
  belongs_to :team_player
  belongs_to :team
end
