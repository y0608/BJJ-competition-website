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

ActiveRecord::Schema[7.1].define(version: 2024_01_27_201719) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brackets", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "first_place_id"
    t.bigint "second_place_id"
    t.bigint "third_place_id"
    t.index ["event_id"], name: "index_brackets_on_event_id"
    t.index ["first_place_id"], name: "index_brackets_on_first_place_id"
    t.index ["second_place_id"], name: "index_brackets_on_second_place_id"
    t.index ["third_place_id"], name: "index_brackets_on_third_place_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at"
    t.string "location", null: false
    t.string "game_type", default: "NoGi", null: false
    t.text "description"
    t.bigint "organizer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "bracket_id", null: false
    t.bigint "competitor1_id"
    t.bigint "competitor2_id"
    t.bigint "winner_id"
    t.bigint "next_match_id"
    t.integer "round", default: 0, null: false
    t.float "timer_value", default: 300.0, null: false
    t.datetime "timer_last_started_at"
    t.boolean "timer_running", default: false, null: false
    t.integer "match_status", default: 0, null: false
    t.integer "points1", default: 0, null: false
    t.integer "points2", default: 0, null: false
    t.integer "advantages1", default: 0, null: false
    t.integer "advantages2", default: 0, null: false
    t.integer "penalties1", default: 0, null: false
    t.integer "penalties2", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bracket_id"], name: "index_matches_on_bracket_id"
    t.index ["competitor1_id"], name: "index_matches_on_competitor1_id"
    t.index ["competitor2_id"], name: "index_matches_on_competitor2_id"
    t.index ["next_match_id"], name: "index_matches_on_next_match_id"
    t.index ["winner_id"], name: "index_matches_on_winner_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "competitor_id", null: false
    t.bigint "bracket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bracket_id"], name: "index_registrations_on_bracket_id"
    t.index ["competitor_id"], name: "index_registrations_on_competitor_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "organization_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weightclasses", force: :cascade do |t|
    t.bigint "bracket_id", null: false
    t.string "age", null: false
    t.string "belt", null: false
    t.string "sex", null: false
    t.float "weight", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bracket_id"], name: "index_weightclasses_on_bracket_id"
  end

  add_foreign_key "brackets", "events"
  add_foreign_key "brackets", "registrations", column: "first_place_id"
  add_foreign_key "brackets", "registrations", column: "second_place_id"
  add_foreign_key "brackets", "registrations", column: "third_place_id"
  add_foreign_key "events", "users", column: "organizer_id"
  add_foreign_key "matches", "brackets"
  add_foreign_key "matches", "matches", column: "next_match_id"
  add_foreign_key "matches", "users", column: "competitor1_id"
  add_foreign_key "matches", "users", column: "competitor2_id"
  add_foreign_key "matches", "users", column: "winner_id"
  add_foreign_key "registrations", "brackets"
  add_foreign_key "registrations", "users", column: "competitor_id"
  add_foreign_key "weightclasses", "brackets"
end
