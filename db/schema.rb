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

ActiveRecord::Schema.define(version: 20131103232551) do

  create_table "blueprints", force: true do |t|
    t.string   "name"
    t.integer  "eve_id"
    t.integer  "manufacturing_time"
    t.integer  "research_manufactoring_efficiency_time"
    t.integer  "research_production_time"
    t.integer  "produced_item_id"
    t.integer  "price_cents"
    t.integer  "invention_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_blueprints", force: true do |t|
    t.integer  "blueprint_id"
    t.integer  "character_id"
    t.integer  "material_level"
    t.integer  "production_efficiency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_skills", force: true do |t|
    t.integer  "character_id"
    t.integer  "skill_id"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.float    "m3"
    t.integer  "price_cents"
    t.integer  "eve_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", force: true do |t|
    t.integer  "blueprint_id"
    t.integer  "item_id"
    t.integer  "ammount"
    t.integer  "percent_consumed"
    t.string   "activity_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
