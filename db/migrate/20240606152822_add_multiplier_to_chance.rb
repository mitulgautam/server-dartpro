# frozen_string_literal: true

# Migration to create Rounds table
# Each Game have multiple teams and each team have multiple players
#  and each player can participate once in each round
class AddMultiplierToChance < ActiveRecord::Migration[7.1]
  def change
    add_column :chances, :multiplier, :integer, default: 1
  end
end
