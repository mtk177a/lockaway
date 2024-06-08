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

ActiveRecord::Schema[7.1].define(version: 2024_06_08_121256) do
  create_table "habit_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "habit_id", null: false
    t.date "date", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id", "date"], name: "index_habit_logs_on_habit_id_and_date", unique: true
    t.index ["habit_id"], name: "index_habit_logs_on_habit_id"
  end

  create_table "habit_rewards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "habit_id", null: false
    t.bigint "reward_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_habit_rewards_on_habit_id"
    t.index ["reward_id"], name: "index_habit_rewards_on_reward_id"
  end

  create_table "habits", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.integer "habit_type", null: false
    t.text "description"
    t.datetime "start_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_completed_days", default: 0
    t.integer "continuous_completed_days", default: 0
    t.float "completion_rate", default: 0.0
    t.integer "highest_continuous_days", default: 0
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "rewards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "condition_type", null: false
    t.integer "threshold", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "habit_logs", "habits"
  add_foreign_key "habit_rewards", "habits"
  add_foreign_key "habit_rewards", "rewards"
  add_foreign_key "habits", "users"
end
