# frozen_string_literal: true

# Migration to create Players table
class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.string :username, null: false

      t.timestamps
    end
    add_index :players, :username, unique: true
  end
end
