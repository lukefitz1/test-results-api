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

ActiveRecord::Schema.define(version: 2020_07_28_234522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "assertions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "assertion_name"
    t.string "assertion_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "request_id"
    t.index ["request_id"], name: "index_assertions_on_request_id"
  end

  create_table "collections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "description"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "feature_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "suite_id"
    t.index ["suite_id"], name: "index_features_on_suite_id"
  end

  create_table "requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "request_id"
    t.string "request_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timestamp"
    t.uuid "collection_id"
    t.index ["collection_id"], name: "index_requests_on_collection_id"
  end

  create_table "scenarios", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "scenario_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "feature_id"
    t.index ["feature_id"], name: "index_scenarios_on_feature_id"
  end

  create_table "steps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "step_name"
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "scenario_id"
    t.index ["scenario_id"], name: "index_steps_on_scenario_id"
  end

  create_table "suites", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "description"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assertions", "requests"
  add_foreign_key "features", "suites"
  add_foreign_key "requests", "collections"
  add_foreign_key "scenarios", "features"
  add_foreign_key "steps", "scenarios"
end
