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

ActiveRecord::Schema.define(version: 20140501101347) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "comment"
  end

  create_table "eventjoinings", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     default: "pending"
  end

  add_index "eventjoinings", ["event_id"], name: "index_eventjoinings_on_event_id"
  add_index "eventjoinings", ["user_id", "event_id"], name: "index_eventjoinings_on_user_id_and_event_id", unique: true
  add_index "eventjoinings", ["user_id"], name: "index_eventjoinings_on_user_id"

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "date"
    t.integer  "capacity"
    t.text     "region"
    t.text     "street"
    t.string   "time"
    t.string   "time_period"
    t.string   "privacy",     default: "medium"
  end

  add_index "events", ["user_id", "created_at"], name: "index_events_on_user_id_and_created_at"

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     default: "request"
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id"
  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id"

  create_table "messages", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",       default: "unread"
    t.boolean  "new_message",  default: true
    t.string   "msgtype"
  end

  create_table "rates", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",      default: 0
  end

  add_index "rates", ["event_id"], name: "index_rates_on_event_id"
  add_index "rates", ["user_id", "event_id"], name: "index_rates_on_user_id_and_event_id", unique: true
  add_index "rates", ["user_id"], name: "index_rates_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                                   default: false
    t.string   "photo"
    t.string   "hobby"
    t.string   "DOB"
    t.string   "gender"
    t.string   "nationality"
    t.string   "mobile"
    t.string   "occupation"
    t.string   "address"
    t.string   "webpage"
    t.string   "self_intro"
    t.decimal  "rate",            precision: 6, scale: 3
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
