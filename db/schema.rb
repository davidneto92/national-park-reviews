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

ActiveRecord::Schema.define(version: 20170517172642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "park_forecasts", force: :cascade do |t|
    t.jsonb    "forecast_day_0"
    t.jsonb    "forecast_day_1"
    t.jsonb    "forecast_day_2"
    t.jsonb    "forecast_day_3"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "park_id"
    t.index ["park_id"], name: "index_park_forecasts_on_park_id", using: :btree
  end

  create_table "park_votes", force: :cascade do |t|
    t.integer  "choice"
    t.integer  "park_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_park_votes_on_park_id", using: :btree
    t.index ["user_id"], name: "index_park_votes_on_user_id", using: :btree
  end

  create_table "parks", force: :cascade do |t|
    t.string   "name",                 null: false
    t.string   "main_image",           null: false
    t.string   "state",                null: false
    t.integer  "year_founded"
    t.integer  "area_miles"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "nearby_city"
    t.datetime "last_forecast_update"
    t.string   "nps_page"
    t.text     "nps_description"
    t.index ["user_id"], name: "index_parks_on_user_id", using: :btree
  end

  create_table "review_votes", force: :cascade do |t|
    t.integer  "choice"
    t.integer  "park_id"
    t.integer  "review_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_review_votes_on_park_id", using: :btree
    t.index ["review_id"], name: "index_review_votes_on_review_id", using: :btree
    t.index ["user_id"], name: "index_review_votes_on_user_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "title",      null: false
    t.string   "body",       null: false
    t.date     "visit_date"
    t.integer  "park_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_reviews_on_park_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "role",                   default: "member"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "avatar"
    t.string   "display_name",                              null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "park_forecasts", "parks"
  add_foreign_key "park_votes", "parks"
  add_foreign_key "park_votes", "users"
  add_foreign_key "parks", "users"
  add_foreign_key "review_votes", "parks"
  add_foreign_key "review_votes", "reviews"
  add_foreign_key "review_votes", "users"
  add_foreign_key "reviews", "parks"
  add_foreign_key "reviews", "users"
end
