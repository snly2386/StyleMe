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

ActiveRecord::Schema.define(version: 20140520113458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "closets", force: true do |t|
    t.integer "user_id"
  end

  create_table "photobooths", force: true do |t|
    t.string  "tags"
    t.text    "content"
    t.text    "images"
    t.integer "user_id"
  end

  create_table "photos", force: true do |t|
    t.string  "file_name"
    t.integer "photobooth_id"
    t.text    "description"
  end

  create_table "results", force: true do |t|
    t.integer "photobooth_id"
    t.text    "description"
    t.string  "url"
    t.string  "shopping_url"
  end

  create_table "sessions", force: true do |t|
    t.integer "user_id"
  end

  create_table "users", force: true do |t|
    t.string  "username"
    t.string  "email"
    t.string  "name"
    t.integer "age"
    t.text    "about_me"
    t.string  "gender"
    t.string  "password"
    t.string  "password_digest"
  end

end
