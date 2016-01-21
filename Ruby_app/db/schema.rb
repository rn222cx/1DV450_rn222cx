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

ActiveRecord::Schema.define(version: 20160120181556) do

  create_table "stories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",       limit: 50
    t.text     "description"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stories", ["user_id", "created_at"], name: "index_stories_on_user_id_and_created_at"
  add_index "stories", ["user_id"], name: "index_stories_on_user_id"

  create_table "tag_types", force: :cascade do |t|
    t.string "era"
  end

  create_table "tags", force: :cascade do |t|
    t.integer  "tag_type_id"
    t.integer  "story_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 20
    t.string   "email",           limit: 50
    t.string   "password_digest"
    t.string   "api_key"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "admin",                      default: false
  end

end
