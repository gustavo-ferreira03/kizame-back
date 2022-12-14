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

ActiveRecord::Schema[7.0].define(version: 2022_06_19_193447) do
  create_table "classroom_modalities", force: :cascade do |t|
    t.integer "modality_id", null: false
    t.integer "classroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_classroom_modalities_on_classroom_id"
    t.index ["modality_id"], name: "index_classroom_modalities_on_modality_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classrooms_users", force: :cascade do |t|
    t.integer "classroom_id"
    t.integer "user_id"
    t.index ["classroom_id"], name: "index_classrooms_users_on_classroom_id"
    t.index ["user_id"], name: "index_classrooms_users_on_user_id"
  end

  create_table "modalities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "practice_attendencies", force: :cascade do |t|
    t.integer "practice_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practice_id"], name: "index_practice_attendencies_on_practice_id"
    t.index ["user_id"], name: "index_practice_attendencies_on_user_id"
  end

  create_table "practices", force: :cascade do |t|
    t.date "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "qr_code_string"
    t.integer "classroom_id", null: false
    t.index ["classroom_id"], name: "index_practices_on_classroom_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "classroom_id", null: false
    t.integer "from_weekday"
    t.integer "to_weekday"
    t.integer "from_time"
    t.integer "to_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_schedules_on_classroom_id"
  end

  create_table "user_modalities", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "modality_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["modality_id"], name: "index_user_modalities_on_modality_id"
    t.index ["user_id"], name: "index_user_modalities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.string "password_confirmation"
    t.string "profile_picture"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "classroom_modalities", "classrooms"
  add_foreign_key "classroom_modalities", "modalities"
  add_foreign_key "practice_attendencies", "practices"
  add_foreign_key "practice_attendencies", "users"
  add_foreign_key "practices", "classrooms"
  add_foreign_key "schedules", "classrooms"
  add_foreign_key "user_modalities", "modalities"
  add_foreign_key "user_modalities", "users"
end
