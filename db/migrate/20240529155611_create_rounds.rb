# frozen_string_literal: true

# Migration to create Rounds table
# Each Game have multiple teams and each team have multiple players
#  and each player can participate once in each round
class CreateRounds < ActiveRecord::Migration[7.1]
  def change
    create_table :rounds do |t|
      t.integer :score, default: 0
      t.integer :current_round, null: false
      t.references :game, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :team_player, null: false, foreign_key: true

      t.timestamps
    end

    add_index :rounds, %i[game_id team_id team_player_id current_round], unique: true
  end
end
