class CreateChances < ActiveRecord::Migration[7.1]
  def change
    create_table :chances do |t|
      t.integer :score, null: false
      t.references :round, null: false, foreign_key: true
      t.references :team_player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
