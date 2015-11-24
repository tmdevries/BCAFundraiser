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

ActiveRecord::Schema.define(version: 20151021155117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: :cascade do |t|
    t.boolean  "active"
    t.date     "event_date"
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal  "amount_raised", precision: 5, scale: 2, default: 0.0, null: false
  end

  create_table "bids", force: :cascade do |t|
    t.decimal "bid_amount"
    t.integer "user_id"
    t.integer "item_id"
  end

  add_index "bids", ["item_id"], name: "index_bids_on_item_id", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "item_title"
    t.string   "item_description"
    t.decimal  "item_value",         precision: 5, scale: 2, default: 0.0, null: false
    t.decimal  "decimal",            precision: 5, scale: 2, default: 0.0, null: false
    t.decimal  "min_increase",       precision: 5, scale: 2, default: 0.0, null: false
    t.decimal  "starting_bid",       precision: 5, scale: 2, default: 0.0, null: false
    t.string   "donor_name"
    t.boolean  "donor_visible"
    t.integer  "auction_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.decimal  "min_bid",            precision: 5, scale: 2
  end

  add_index "items", ["auction_id"], name: "index_items_on_auction_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string  "email"
    t.string  "password_digest"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "phone_number"
    t.boolean "name_visible"
    t.boolean "notify_by_text"
    t.boolean "notify_by_email"
    t.boolean "admin"
    t.string  "auth_token"
    t.string  "remember_digest"
  end

  add_foreign_key "bids", "items"
  add_foreign_key "bids", "users"
  add_foreign_key "items", "auctions"
end
