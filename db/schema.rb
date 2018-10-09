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

ActiveRecord::Schema.define(version: 2018_10_08_015007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alternative_questions", force: :cascade do |t|
    t.bigint "survey_id"
    t.text "statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_alternative_questions_on_survey_id"
  end

  create_table "alternative_responses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "alternative_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alternative_id"], name: "index_alternative_responses_on_alternative_id"
    t.index ["user_id"], name: "index_alternative_responses_on_user_id"
  end

  create_table "alternatives", force: :cascade do |t|
    t.bigint "alternative_question_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alternative_question_id"], name: "index_alternatives_on_alternative_question_id"
  end

  create_table "careers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.boolean "subscribable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_categories", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_group_categories_on_category_id"
    t.index ["group_id"], name: "index_group_categories_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "multiple_alternatives", force: :cascade do |t|
    t.bigint "multiple_question_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["multiple_question_id"], name: "index_multiple_alternatives_on_multiple_question_id"
  end

  create_table "multiple_questions", force: :cascade do |t|
    t.bigint "survey_id"
    t.text "statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_multiple_questions_on_survey_id"
  end

  create_table "multiple_responses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "multiple_alternative_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["multiple_alternative_id"], name: "index_multiple_responses_on_multiple_alternative_id"
    t.index ["user_id"], name: "index_multiple_responses_on_user_id"
  end

  create_table "open_questions", force: :cascade do |t|
    t.bigint "survey_id"
    t.text "statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_open_questions_on_survey_id"
  end

  create_table "open_responses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "open_question_id"
    t.text "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["open_question_id"], name: "index_open_responses_on_open_question_id"
    t.index ["user_id"], name: "index_open_responses_on_user_id"
  end

  create_table "prizes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "score"
    t.boolean "available"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_categories", force: :cascade do |t|
    t.bigint "survey_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_survey_categories_on_category_id"
    t.index ["survey_id"], name: "index_survey_categories_on_survey_id"
  end

  create_table "survey_states", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "survey_id"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_states_on_survey_id"
    t.index ["user_id", "survey_id"], name: "index_survey_states_on_user_id_and_survey_id", unique: true
    t.index ["user_id"], name: "index_survey_states_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "score"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "max_answers"
    t.integer "min_answers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_categories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "user_histories", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "cumulative_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_histories_on_user_id"
  end

  create_table "user_prizes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "prize_id"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prize_id"], name: "index_user_prizes_on_prize_id"
    t.index ["user_id"], name: "index_user_prizes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "birthdate"
    t.string "gender"
    t.string "rut"
    t.boolean "active"
    t.integer "accumulated_score"
    t.bigint "career_id"
    t.string "auth_token"
    t.index ["career_id"], name: "index_users_on_career_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "alternative_questions", "surveys"
  add_foreign_key "alternative_responses", "alternatives"
  add_foreign_key "alternative_responses", "users"
  add_foreign_key "alternatives", "alternative_questions"
  add_foreign_key "group_categories", "categories"
  add_foreign_key "group_categories", "groups"
  add_foreign_key "multiple_alternatives", "multiple_questions"
  add_foreign_key "multiple_questions", "surveys"
  add_foreign_key "multiple_responses", "multiple_alternatives"
  add_foreign_key "multiple_responses", "users"
  add_foreign_key "open_questions", "surveys"
  add_foreign_key "open_responses", "open_questions"
  add_foreign_key "open_responses", "users"
  add_foreign_key "survey_categories", "categories"
  add_foreign_key "survey_categories", "surveys"
  add_foreign_key "survey_states", "surveys"
  add_foreign_key "survey_states", "users"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_categories", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
  add_foreign_key "user_histories", "users"
  add_foreign_key "user_prizes", "prizes"
  add_foreign_key "user_prizes", "users"
end
