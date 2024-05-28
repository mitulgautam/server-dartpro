# frozen_string_literal: true

# Migration to create TeamPlayers table
# It will hold players data for a specific team.
class CreateTeamPlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :team_players do |t|
      t.references :team, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :score, default: 0
      t.boolean :is_captain, default: false

      t.timestamps
    end
  end
end
