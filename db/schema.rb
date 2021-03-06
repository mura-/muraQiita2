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

ActiveRecord::Schema.define(version: 20151002052718) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,     null: false
    t.integer  "tip_id",     limit: 4,     null: false
    t.text     "content",    limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["tip_id", "user_id"], name: "index_comments_on_tip_id_and_user_id", using: :btree
  add_index "comments", ["user_id"], name: "fk_rails_03de2dc08c", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",       limit: 4,                     null: false
    t.text     "content",       limit: 65535,                 null: false
    t.boolean  "is_checked",                  default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "reference_url", limit: 255
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "tip_id",     limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "stocks", ["tip_id"], name: "index_stocks_on_tip_id", using: :btree
  add_index "stocks", ["user_id"], name: "index_stocks_on_user_id", using: :btree

  create_table "tag_follows", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "tag_id",     limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "tag_follows", ["tag_id"], name: "fk_rails_0deefe597f", using: :btree
  add_index "tag_follows", ["user_id"], name: "fk_rails_ff9673621f", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tips", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,     null: false
    t.string   "title",      limit: 255,   null: false
    t.text     "content",    limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "user_follows", force: :cascade do |t|
    t.integer  "user_id",     limit: 4, null: false
    t.integer  "follow_user", limit: 4, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "user_follows", ["follow_user"], name: "fk_rails_5c6108c2d1", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",          null: false
    t.string   "encrypted_password",     limit: 255, default: "",          null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "username",               limit: 255, default: "anonymous"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,           null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "comments", "tips"
  add_foreign_key "comments", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "stocks", "tips"
  add_foreign_key "stocks", "users"
  add_foreign_key "tag_follows", "tags"
  add_foreign_key "tag_follows", "users"
  add_foreign_key "user_follows", "users", column: "follow_user"
end
