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

ActiveRecord::Schema.define(version: 20140509233114) do

  create_table "closets", force: true do |t|
    t.integer "photobooths_id"
    t.integer "user_id"
  end

  create_table "photobooths", force: true do |t|
    t.integer "photo_id"
    t.integer "result_id"
    t.integer "closet_id"
    t.text    "tags"
    t.text    "content"
    t.text    "images"
  end

  create_table "photos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "file_name"
    t.integer  "user_id"
  end

  create_table "results", force: true do |t|
  end

  create_table "sessions", force: true do |t|
    t.integer "user_id"
  end

  create_table "users", force: true do |t|
    t.integer  "closet_id"
    t.string   "username"
    t.string   "name"
    t.integer  "age"
    t.text     "about_me"
    t.string   "gender"
    t.integer  "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
