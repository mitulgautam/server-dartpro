# frozen_string_literal: true

# Migration to create Rounds table
# Each Game have multiple teams and each team have multiple players
#  and each player can participate once in each round
class CreateTurnTrackers < ActiveRecord::Migration[7.1]
  def change
    create_table :turn_trackers do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :current_player_id
      t.integer :next_player_id
      t.integer :current_team_id
      t.integer :next_team_id

      t.timestamps
    end
    add_index :turn_trackers, %i[game_id], unique: true, name: 'turn_trackers_un_game_id'
  end
end
