# frozen_string_literal: true

# Migration to create Rounds table
# Each Game have multiple teams and each team have multiple players
#  and each player can participate once in each round
class CreateTurnOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :turn_orders do |t|
      t.references :game, null: false, foreign_key: true
      t.references :team_player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :turn_order

      t.timestamps
    end
    add_index :turn_orders, %i[game_id team_id turn_order], unique: true
  end
end
