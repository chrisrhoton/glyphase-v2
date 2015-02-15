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

ActiveRecord::Schema.define(version: 20150214204802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "glyph_id"
    t.text     "text"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "image_attachment"
  end

  add_index "comments", ["glyph_id"], name: "index_comments_on_glyph_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "glyphs", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.decimal  "latitude",         precision: 9, scale: 6
    t.decimal  "longitude",        precision: 9, scale: 6
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "tagline"
    t.string   "title"
    t.string   "image_attachment"
  end

  add_index "glyphs", ["user_id", "created_at"], name: "index_glyphs_on_user_id_and_created_at", using: :btree
  add_index "glyphs", ["user_id"], name: "index_glyphs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.string   "profile_image"
    t.string   "remember_digest"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "comments", "glyphs"
  add_foreign_key "comments", "users"
  add_foreign_key "glyphs", "users"
end