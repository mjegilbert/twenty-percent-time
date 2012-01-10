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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120107020236) do

  create_table "companies", :force => true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ed_sessions", :force => true do |t|
    t.integer  "minion_id"
    t.integer  "school_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "degree"
    t.text     "major"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.integer  "minion_id"
    t.integer  "company_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "position"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "minions", :force => true do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.text     "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", :force => true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
