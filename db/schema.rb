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

ActiveRecord::Schema.define(version: 20161004235607) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accounts", ["account_id"], name: "index_accounts_on_account_id"

  create_table "entities", force: :cascade do |t|
    t.string   "name"
    t.integer  "no"
    t.float    "frac"
    t.string   "unit"
    t.string   "street"
    t.string   "box"
    t.string   "city"
    t.string   "polsub"
    t.string   "postal"
    t.string   "nation"
    t.string   "phone"
    t.string   "email"
    t.text     "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", force: :cascade do |t|
    t.integer  "transaktion_id"
    t.integer  "item_id"
    t.integer  "price"
    t.float    "qty"
    t.boolean  "is_debit"
    t.integer  "account_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "entries", ["account_id"], name: "index_entries_on_account_id"
  add_index "entries", ["item_id"], name: "index_entries_on_item_id"
  add_index "entries", ["transaktion_id"], name: "index_entries_on_transaktion_id"

  create_table "items", force: :cascade do |t|
    t.string   "barcode"
    t.string   "brand"
    t.string   "gendesc"
    t.float    "size"
    t.integer  "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "items", ["unit_id"], name: "index_items_on_unit_id"

  create_table "transaktions", force: :cascade do |t|
    t.datetime "date"
    t.integer  "entity_id"
    t.boolean  "is_void"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transaktions", ["entity_id"], name: "index_transaktions_on_entity_id"

  create_table "units", force: :cascade do |t|
    t.string   "unit"
    t.float    "factor"
    t.integer  "m"
    t.integer  "kg"
    t.integer  "s"
    t.integer  "a"
    t.integer  "k"
    t.integer  "cd"
    t.integer  "mol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
