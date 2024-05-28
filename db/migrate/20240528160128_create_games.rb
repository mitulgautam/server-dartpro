# frozen_string_literal: true

# Migration to create Games table
class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :game_type, null: false
      t.integer :winner_team_id
      t.integer :rounds, null: false
      t.integer :chance_per_round, null: false
      t.integer :top_scorer_id
      t.integer :top_scorer_score

      t.timestamps
    end
  end
end
