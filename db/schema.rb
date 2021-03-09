# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_08_233952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.string "form"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "fplid"
  end

  create_table "fixtures", force: :cascade do |t|
    t.datetime "kickoff"
    t.integer "gameweek"
    t.integer "h_score"
    t.integer "a_score"
    t.bigint "home_team_id", null: false
    t.bigint "away_team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["away_team_id"], name: "index_fixtures_on_away_team_id"
    t.index ["home_team_id"], name: "index_fixtures_on_home_team_id"
  end

  create_table "footballers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "web_name"
    t.integer "price"
    t.string "position"
    t.integer "expected_points"
    t.integer "total_points"
    t.integer "goals"
    t.integer "assists"
    t.integer "clean_sheets"
    t.integer "yellow_cards"
    t.integer "red_cards"
    t.integer "saves"
    t.integer "goals_conceded"
    t.integer "own_goals"
    t.integer "penalties_saved"
    t.integer "penalties_missed"
    t.integer "bonus"
    t.integer "bps"
    t.bigint "club_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "fplid", null: false
    t.integer "chance_of_playing_next_round"
    t.integer "chance_of_playing_this_round"
    t.text "news"
    t.string "form"
    t.index ["club_id"], name: "index_footballers_on_club_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.integer "fpl_league_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "odds", force: :cascade do |t|
    t.string "event"
    t.float "probability"
    t.bigint "footballer_id", null: false
    t.bigint "fixture_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fixture_id"], name: "index_odds_on_fixture_id"
    t.index ["footballer_id"], name: "index_odds_on_footballer_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "footballer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "starter", default: false
    t.integer "bench_pos"
    t.index ["footballer_id"], name: "index_players_on_footballer_id"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "team_entries", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "league_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["league_id"], name: "index_team_entries_on_league_id"
    t.index ["team_id"], name: "index_team_entries_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "fpl_team_id"
    t.string "name"
    t.integer "summary_overall_points"
    t.integer "summary_overall_rank"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "budget"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "fixtures", "clubs", column: "away_team_id"
  add_foreign_key "fixtures", "clubs", column: "home_team_id"
  add_foreign_key "footballers", "clubs"
  add_foreign_key "odds", "fixtures"
  add_foreign_key "odds", "footballers"
  add_foreign_key "players", "footballers"
  add_foreign_key "players", "teams"
  add_foreign_key "team_entries", "leagues"
  add_foreign_key "team_entries", "teams"
  add_foreign_key "teams", "users"
end
