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

ActiveRecord::Schema[7.1].define(version: 2024_04_08_172604) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "role", null: false
    t.string "riot_id", null: false
    t.string "summoner_id", null: false
    t.string "puuid", null: false
    t.integer "profile_icon_id", null: false
    t.integer "summoner_level", null: false
    t.integer "ordering"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "ai_prediction_finish"
  end

  create_table "entries", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "tier"
    t.string "rank"
    t.integer "league_points"
    t.integer "wins"
    t.integer "losses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_entries_on_account_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "riot_id", null: false
    t.string "role", null: false
    t.boolean "win", null: false
    t.datetime "started_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_matches_on_account_id"
  end

  add_foreign_key "entries", "accounts"
  add_foreign_key "matches", "accounts"
end
