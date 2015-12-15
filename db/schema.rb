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

ActiveRecord::Schema.define(version: 20151215142858) do

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
    t.integer  "transaction_id"
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
  add_index "entries", ["transaction_id"], name: "index_entries_on_transaction_id"

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

  create_table "transactions", force: :cascade do |t|
    t.datetime "date"
    t.integer  "entity_id"
    t.boolean  "is_void"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["entity_id"], name: "index_transactions_on_entity_id"

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

end
