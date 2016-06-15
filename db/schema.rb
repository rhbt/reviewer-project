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

ActiveRecord::Schema.define(version: 20160612081336) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "review_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["review_id", "created_at"], name: "index_comments_on_review_id_and_created_at", using: :btree
  add_index "comments", ["review_id"], name: "index_comments_on_review_id", using: :btree
  add_index "comments", ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string   "url"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "rating"
  end

  add_index "reviews", ["url"], name: "index_reviews_on_url", unique: true, using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "saved_reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "saved_reviews", ["review_id"], name: "index_saved_reviews_on_review_id", using: :btree
  add_index "saved_reviews", ["user_id", "created_at"], name: "index_saved_reviews_on_user_id_and_created_at", using: :btree
  add_index "saved_reviews", ["user_id"], name: "index_saved_reviews_on_user_id", using: :btree

  create_table "stickied_reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stickied_reviews", ["review_id"], name: "index_stickied_reviews_on_review_id", using: :btree
  add_index "stickied_reviews", ["user_id", "created_at"], name: "index_stickied_reviews_on_user_id_and_created_at", using: :btree
  add_index "stickied_reviews", ["user_id"], name: "index_stickied_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.datetime "last_review"
    t.datetime "last_comment"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "comments", "reviews"
  add_foreign_key "comments", "users"
  add_foreign_key "reviews", "users"
  add_foreign_key "saved_reviews", "reviews"
  add_foreign_key "saved_reviews", "users"
  add_foreign_key "stickied_reviews", "reviews"
  add_foreign_key "stickied_reviews", "users"
end
