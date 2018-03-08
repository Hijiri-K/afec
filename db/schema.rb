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

ActiveRecord::Schema.define(version: 20180306071023) do

  create_table "exchanges", force: :cascade do |t|
    t.string "currency"
    t.float "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maps", force: :cascade do |t|
    t.string "airports"
    t.string "terminals"
    t.string "floor_maps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "cafe_lat"
    t.float "cafe_lng"
    t.float "center_lat"
    t.float "center_lng"
    t.float "rotations"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.text "currency_have"
    t.float "currency_have_amount"
    t.text "currency_want"
    t.text "location"
    t.decimal "lat"
    t.decimal "lng"
    t.float "currency_want_amount"
    t.integer "offer"
    t.integer "terminal"
    t.string "group"
    t.string "stream"
  end

  create_table "updates", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_name"
    t.string "password"
    t.string "group"
  end

end
