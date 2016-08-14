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

ActiveRecord::Schema.define(version: 20160814212255) do

  create_table "products", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "sku",         limit: 255,   default: "SKU01", null: false
    t.integer  "count",       limit: 4,     default: 0,       null: false
    t.text     "description", limit: 65535
  end

  add_index "products", ["name"], name: "index_products_on_name", using: :btree
  add_index "products", ["sku"], name: "index_products_on_sku", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               limit: 255
    t.string   "crypted_password",    limit: 255
    t.string   "password_salt",       limit: 255
    t.string   "persistence_token",   limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "login_count",         limit: 4,   default: 0,     null: false
    t.integer  "failed_login_count",  limit: 4,   default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip",    limit: 255
    t.string   "last_login_ip",       limit: 255
    t.string   "perishable_token",    limit: 255
    t.boolean  "active",                          default: false, null: false
    t.boolean  "approved",                        default: false
    t.boolean  "confirmed",                       default: false
    t.string   "single_access_token", limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
