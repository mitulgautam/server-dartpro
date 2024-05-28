# frozen_string_literal: true

# Migration to create GameTeams table
class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.references :game, null: false, foreign_key: true
      t.integer :score, default: 0
      t.boolean :is_winner, default: false

      t.timestamps
    end
  end
end
