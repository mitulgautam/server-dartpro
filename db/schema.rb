# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_06_152822) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chances", force: :cascade do |t|
    t.integer "score", null: false
    t.bigint "round_id", null: false
    t.bigint "team_player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "multiplier", default: 1
    t.index ["round_id"], name: "index_chances_on_round_id"
    t.index ["team_player_id"], name: "index_chances_on_team_player_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "game_type", null: false
    t.integer "winner_team_id"
    t.integer "rounds", null: false
    t.integer "chance_per_round", null: false
    t.integer "top_scorer_id"
    t.integer "top_scorer_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_players_on_username", unique: true
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "score", default: 0
    t.integer "current_round", null: false
    t.bigint "game_id", null: false
    t.bigint "team_id", null: false
    t.bigint "team_player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "team_id", "team_player_id", "current_round"], name: "idx_on_game_id_team_id_team_player_id_current_round_5704a58949", unique: true
    t.index ["game_id"], name: "index_rounds_on_game_id"
    t.index ["team_id"], name: "index_rounds_on_team_id"
    t.index ["team_player_id"], name: "index_rounds_on_team_player_id"
  end

  create_table "team_players", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "player_id", null: false
    t.integer "score", default: 0
    t.boolean "is_captain", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_team_players_on_player_id"
    t.index ["team_id"], name: "index_team_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "game_id", null: false
    t.integer "score", default: 0
    t.boolean "is_winner", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_teams_on_game_id"
  end

  create_table "turn_orders", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "team_player_id", null: false
    t.bigint "team_id", null: false
    t.integer "turn_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "team_id", "turn_order"], name: "index_turn_orders_on_game_id_and_team_id_and_turn_order", unique: true
    t.index ["game_id"], name: "index_turn_orders_on_game_id"
    t.index ["team_id"], name: "index_turn_orders_on_team_id"
    t.index ["team_player_id"], name: "index_turn_orders_on_team_player_id"
  end

  create_table "turn_trackers", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "current_player_id"
    t.integer "next_player_id"
    t.integer "current_team_id"
    t.integer "next_team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_turn_trackers_on_game_id"
    t.index ["game_id"], name: "turn_trackers_un_game_id", unique: true
  end

  add_foreign_key "chances", "rounds"
  add_foreign_key "chances", "team_players"
  add_foreign_key "rounds", "games"
  add_foreign_key "rounds", "team_players"
  add_foreign_key "rounds", "teams"
  add_foreign_key "team_players", "players"
  add_foreign_key "team_players", "teams"
  add_foreign_key "teams", "games"
  add_foreign_key "turn_orders", "games"
  add_foreign_key "turn_orders", "team_players"
  add_foreign_key "turn_orders", "teams"
  add_foreign_key "turn_trackers", "games"
end
