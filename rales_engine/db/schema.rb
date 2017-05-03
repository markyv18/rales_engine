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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20170503040529) do
=======
ActiveRecord::Schema.define(version: 20170503050709) do
>>>>>>> 7848cec71f109f19b9c26acc36a3ac12737d1048

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoice_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "quantity"
    t.string   "unit_price"
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id", using: :btree
    t.index ["item_id"], name: "index_invoice_items_on_item_id", using: :btree
  end

  create_table "invoices", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
  end

<<<<<<< HEAD
  create_table "orders", force: :cascade do |t|
    t.string   "order_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoice_items", "items"
=======
  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "credit_card"
    t.string   "result"
    t.integer  "invoice_id"
    t.datetime "created_at",  precision: 0
    t.datetime "updated_at",  precision: 0
  end

>>>>>>> 7848cec71f109f19b9c26acc36a3ac12737d1048
end
