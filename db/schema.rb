# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_02_093346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.integer "sub1"
    t.integer "sub2"
    t.text "log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "player_1_verdict"
    t.string "player_2_verdict"
    t.string "status"
    t.bigint "tournament_id"
    t.boolean "is_draw"
    t.integer "winner"
    t.integer "player1_id"
    t.integer "player2_id"
    t.integer "winner_id"
    t.bigint "user_id"
    t.bigint "submission_id"
    t.string "state_par"
    t.datetime "tested_time"
    t.datetime "started_testing_at"
    t.index ["submission_id"], name: "index_challenges_on_submission_id"
    t.index ["tournament_id"], name: "index_challenges_on_tournament_id"
    t.index ["user_id"], name: "index_challenges_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "rules_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.string "statement_file"
    t.string "visualizer_file"
    t.string "checker_file"
    t.string "solution_file"
    t.float "timeout"
    t.integer "memory_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "judges", force: :cascade do |t|
    t.string "name"
    t.string "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "submissions", force: :cascade do |t|
    t.string "compiler"
    t.text "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "status"
    t.string "name"
    t.boolean "used_for_ch"
    t.boolean "used_for_tours"
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.integer "number_of_ch_per_pair"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "participants"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rating"
    t.integer "fav_ch_id"
    t.integer "fav_tours_id"
    t.string "role"
    t.string "name"
    t.string "surname"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
