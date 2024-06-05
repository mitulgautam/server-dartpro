# frozen_string_literal: true

# Model for Game with validations
class Game < ApplicationRecord
  has_many :teams, dependent: :destroy

  validates :game_type, :rounds, :chance_per_round, presence: true
  validates :rounds, :chance_per_round, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :teams

  after_create :create_turn_orders
  after_create :create_turn_tracker

  def create_turn_orders
    # TURN ORDER CREATE
    teams.each do |team|
      team&.team_players&.order(id: :asc)&.each_with_index do |player, idx|
        turn = TurnOrder.new
        turn.game_id = id
        turn.team_id = player.team_id
        turn.team_player_id = player.id
        turn.turn_order = idx + 1
        turn.save!
      end
    end
  end

  def create_turn_tracker
    # TURN TRACKER CREATE
    tracker = TurnTracker.new
    tracker.game_id = teams&.first&.game_id
    tracker.current_player_id = teams&.first&.team_players&.order(id: :asc)&.first&.id
    tracker.next_player_id = teams&.second&.team_players&.order(id: :asc)&.first&.id
    tracker.current_team_id = teams&.first&.id
    tracker.next_team_id = teams&.second&.id
    tracker.save!
  end
end
