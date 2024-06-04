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
    add_index :turn_trackers, %i[id game_id], unique: true
  end
end
