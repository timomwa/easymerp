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

ActiveRecord::Schema.define(version: 20160924115011) do

  create_table "account_balances", force: :cascade do |t|
    t.integer "account_id",           limit: 4
    t.integer "accounting_period_id", limit: 4
    t.decimal "amount",                         precision: 35, scale: 5
  end

  add_index "account_balances", ["account_id"], name: "fk_rails_f3e5781e9c", using: :btree
  add_index "account_balances", ["accounting_period_id"], name: "fk_rails_06e651f9bb", using: :btree

  create_table "accounting_periods", force: :cascade do |t|
    t.string   "name",     limit: 255,             null: false
    t.datetime "fromDate",                         null: false
    t.datetime "toDate",                           null: false
    t.integer  "status",   limit: 1,   default: 1, null: false
  end

  add_index "accounting_periods", ["fromDate"], name: "index_accounting_periods_on_fromDate", unique: true, using: :btree
  add_index "accounting_periods", ["name"], name: "index_accounting_periods_on_name", unique: true, using: :btree
  add_index "accounting_periods", ["toDate"], name: "index_accounting_periods_on_toDate", unique: true, using: :btree

  create_table "accounts", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "code",        limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "description", limit: 255
  end

  add_index "accounts", ["code"], name: "index_accounts_on_code", unique: true, using: :btree
  add_index "accounts", ["name"], name: "index_accounts_on_name", unique: true, using: :btree

  create_table "general_ledgers", force: :cascade do |t|
    t.integer  "account_id",           limit: 4
    t.integer  "accounting_period_id", limit: 4
    t.decimal  "amount",                             precision: 35, scale: 5
    t.datetime "entry_date",                                                                      null: false
    t.integer  "cr_dr_flag",           limit: 4,                              default: 1
    t.string   "transaction_ref",      limit: 255,                            default: "TXN000",  null: false
    t.string   "seq",                  limit: 255,                            default: "SEQ0001", null: false
    t.text     "description",          limit: 65535
  end

  add_index "general_ledgers", ["account_id"], name: "fk_rails_f7438793fe", using: :btree
  add_index "general_ledgers", ["accounting_period_id"], name: "fk_rails_34644d4699", using: :btree
  add_index "general_ledgers", ["seq"], name: "index_general_ledgers_on_seq", unique: true, using: :btree
  add_index "general_ledgers", ["transaction_ref"], name: "index_general_ledgers_on_transaction_ref", unique: true, using: :btree

  create_table "gl_mappings", force: :cascade do |t|
    t.integer  "transaction_type_id", limit: 4, null: false
    t.integer  "debit_account_id",    limit: 4, null: false
    t.integer  "credit_account_id",   limit: 4, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "gl_mappings", ["credit_account_id"], name: "fk_rails_5092de7b19", using: :btree
  add_index "gl_mappings", ["debit_account_id"], name: "fk_rails_f075530971", using: :btree
  add_index "gl_mappings", ["transaction_type_id", "debit_account_id", "credit_account_id"], name: "typedrcridx", unique: true, using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "product_id", limit: 4,                   null: false
    t.string   "avatar",     limit: 255
    t.integer  "owner_type", limit: 2,   default: 0,     null: false
    t.boolean  "active"
    t.boolean  "defaultimg",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["active"], name: "imgactvidx", using: :btree
  add_index "images", ["defaultimg"], name: "imgdeftimgidx", using: :btree
  add_index "images", ["owner_type"], name: "imgtpeidx", using: :btree
  add_index "images", ["product_id", "owner_type", "active", "defaultimg"], name: "imguniqcstridx", unique: true, using: :btree
  add_index "images", ["product_id"], name: "imgprdidx", using: :btree

  create_table "inventories", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "inventory_products", force: :cascade do |t|
    t.integer "inventory_id", limit: 4
    t.integer "product_id",   limit: 4
  end

  add_index "inventory_products", ["inventory_id"], name: "fk_rails_7637bc1835", using: :btree
  add_index "inventory_products", ["product_id"], name: "fk_rails_b27370d0a4", using: :btree

  create_table "product_discounts", force: :cascade do |t|
    t.integer  "product_id", limit: 4,                                          null: false
    t.integer  "type",       limit: 2,                          default: 0,     null: false
    t.decimal  "percent",              precision: 35, scale: 5
    t.datetime "date_from"
    t.datetime "date_to"
    t.boolean  "active",                                        default: false
  end

  add_index "product_discounts", ["date_from"], name: "pddtfrmidx", using: :btree
  add_index "product_discounts", ["date_to"], name: "pddttoidx", using: :btree
  add_index "product_discounts", ["product_id", "date_from", "date_to", "type"], name: "discntsidx", unique: true, using: :btree
  add_index "product_discounts", ["product_id"], name: "pdprodctidx", using: :btree
  add_index "product_discounts", ["type"], name: "pdtpidx", using: :btree

  create_table "product_pricings", force: :cascade do |t|
    t.integer  "product_id", limit: 4,                          null: false
    t.datetime "date_from"
    t.datetime "date_to"
    t.decimal  "amount",               precision: 35, scale: 5
  end

  add_index "product_pricings", ["date_from", "date_to"], name: "dtrangeidx", unique: true, using: :btree
  add_index "product_pricings", ["date_from"], name: "dtfrmidx", using: :btree
  add_index "product_pricings", ["date_to"], name: "dttoidx", using: :btree
  add_index "product_pricings", ["product_id"], name: "prodidx", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "sku",              limit: 255,   default: "SKU01", null: false
    t.integer  "count",            limit: 4,     default: 0,       null: false
    t.text     "description",      limit: 65535
    t.integer  "vehicle_model_id", limit: 4
  end

  add_index "products", ["name"], name: "index_products_on_name", using: :btree
  add_index "products", ["sku"], name: "index_products_on_sku", unique: true, using: :btree
  add_index "products", ["vehicle_model_id"], name: "index_products_on_vehicle_model_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  create_table "sequences", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "prefix",     limit: 255, null: false
    t.string   "suffix",     limit: 255, null: false
    t.integer  "next_val",   limit: 8,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sequences", ["prefix", "suffix"], name: "index_sequences_on_prefix_and_suffix", unique: true, using: :btree

  create_table "transaction_types", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "trx_code",    limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "description", limit: 255
  end

  add_index "transaction_types", ["name"], name: "index_transaction_types_on_name", unique: true, using: :btree
  add_index "transaction_types", ["trx_code"], name: "index_transaction_types_on_trx_code", unique: true, using: :btree

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

  create_table "vehicle_makes", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "vehicle_makes", ["name"], name: "index_vehicle_makes_on_name", unique: true, using: :btree

  create_table "vehicle_models", force: :cascade do |t|
    t.string  "name",            limit: 255, null: false
    t.integer "year",            limit: 4,   null: false
    t.integer "vehicle_make_id", limit: 4,   null: false
  end

  add_index "vehicle_models", ["name", "year", "vehicle_make_id"], name: "vclemakeid", unique: true, using: :btree
  add_index "vehicle_models", ["name"], name: "index_vehicle_models_on_name", using: :btree
  add_index "vehicle_models", ["vehicle_make_id"], name: "index_vehicle_models_on_vehicle_make_id", using: :btree
  add_index "vehicle_models", ["year"], name: "index_vehicle_models_on_year", using: :btree

  add_foreign_key "account_balances", "accounting_periods"
  add_foreign_key "account_balances", "accounts"
  add_foreign_key "general_ledgers", "accounting_periods"
  add_foreign_key "general_ledgers", "accounts"
  add_foreign_key "gl_mappings", "accounts", column: "credit_account_id"
  add_foreign_key "gl_mappings", "accounts", column: "debit_account_id"
  add_foreign_key "gl_mappings", "transaction_types"
  add_foreign_key "images", "products"
  add_foreign_key "inventory_products", "inventories"
  add_foreign_key "inventory_products", "products"
  add_foreign_key "product_discounts", "products"
  add_foreign_key "product_pricings", "products"
  add_foreign_key "products", "vehicle_models", name: "prodvclmdidx"
  add_foreign_key "vehicle_models", "vehicle_makes"
end
