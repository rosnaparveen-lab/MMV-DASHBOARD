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

ActiveRecord::Schema[7.1].define(version: 2026_05_09_123001) do
  create_table "carrier_map_two_wheelers", force: :cascade do |t|
    t.string "carrier_vehicle_name"
    t.string "carrier_vehicle_code"
    t.string "insurance_code"
    t.string "vehicle_code"
    t.string "vehicle_type"
    t.string "fuel_type"
    t.integer "cubic_capacity"
    t.integer "seating_capacity"
    t.string "carrier_make_code"
    t.text "additional_info"
    t.boolean "declain"
    t.integer "two_wheeler_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["two_wheeler_id"], name: "index_carrier_map_two_wheelers_on_two_wheeler_id"
  end

  create_table "download_logs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "downloaded_item"
    t.string "downloaded_filename"
    t.float "duration_seconds"
    t.index ["user_id"], name: "index_download_logs_on_user_id"
  end

  create_table "user_activities", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "action"
    t.text "details"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_activities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "role"
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "active"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "carrier_map_two_wheelers", "two_wheelers"
  add_foreign_key "download_logs", "users"
  add_foreign_key "user_activities", "users"
end
