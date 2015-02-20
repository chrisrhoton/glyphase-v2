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

ActiveRecord::Schema.define(version: 20150220141246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "glyph_id"
    t.text     "text"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "image_attachment"
    t.string   "panda_video_id",   default: ""
  end

  add_index "comments", ["glyph_id"], name: "index_comments_on_glyph_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "follow_relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follow_relationships", ["followed_id"], name: "index_follow_relationships_on_followed_id", using: :btree
  add_index "follow_relationships", ["follower_id", "followed_id"], name: "index_follow_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "follow_relationships", ["follower_id"], name: "index_follow_relationships_on_follower_id", using: :btree

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
    t.string   "header_image"
    t.string   "panda_video_id"
  end

  add_index "glyphs", ["user_id", "created_at"], name: "index_glyphs_on_user_id_and_created_at", using: :btree
  add_index "glyphs", ["user_id"], name: "index_glyphs_on_user_id", using: :btree

  create_table "spatial_ref_sys", primary_key: "srid", force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

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

  create_table "view_relationships", force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "glyph_id", null: false
  end

  add_index "view_relationships", ["user_id", "glyph_id"], name: "index_view_relationships_on_user_id_and_glyph_id", unique: true, using: :btree

  add_foreign_key "comments", "glyphs"
  add_foreign_key "comments", "users"
  add_foreign_key "glyphs", "users"
end
