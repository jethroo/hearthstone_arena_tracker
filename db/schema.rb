# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150317080249) do

  create_table "arenas", force: :cascade do |t|
    t.integer  "hero",        limit: 4
    t.boolean  "paid",        limit: 1, default: false
    t.datetime "finished_at"
    t.integer  "packs",       limit: 4
    t.integer  "dust",        limit: 4
    t.integer  "gold",        limit: 4
    t.integer  "cards",       limit: 4
    t.integer  "gold_cards",  limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "opponent",   limit: 4
    t.boolean  "won",        limit: 1
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "arena_id",   limit: 4
    t.integer  "user_id",    limit: 4
  end

  add_index "matches", ["user_id"], name: "index_matches_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

end
