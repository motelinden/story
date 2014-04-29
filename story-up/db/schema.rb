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

ActiveRecord::Schema.define(version: 20140427103218) do

  create_table "actions", force: true do |t|
    t.integer  "story_id"
    t.integer  "node_id"
    t.integer  "user_id"
    t.integer  "action_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "actions", ["node_id"], name: "index_actions_on_node_id"
  add_index "actions", ["story_id"], name: "index_actions_on_story_id"
  add_index "actions", ["user_id"], name: "index_actions_on_user_id"

  create_table "comments", force: true do |t|
    t.integer  "user_id",                 null: false
    t.integer  "story_id",                null: false
    t.integer  "node_id",                 null: false
    t.integer  "parent_id"
    t.text     "content",    default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["node_id"], name: "index_comments_on_node_id"
  add_index "comments", ["story_id"], name: "index_comments_on_story_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "nodes", force: true do |t|
    t.integer  "story_id",                null: false
    t.integer  "parent_id"
    t.integer  "user_id",                 null: false
    t.integer  "level",      default: 2,  null: false
    t.text     "path"
    t.text     "content",    default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nodes", ["story_id"], name: "index_nodes_on_story_id"
  add_index "nodes", ["user_id"], name: "index_nodes_on_user_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "statistics", force: true do |t|
    t.integer  "story_id",               null: false
    t.integer  "node_id",    default: 0, null: false
    t.integer  "reading",    default: 0, null: false
    t.integer  "rating",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "follows",    default: 0, null: false
    t.integer  "comments",   default: 0, null: false
  end

  add_index "statistics", ["node_id"], name: "index_statistics_on_node_id"
  add_index "statistics", ["story_id"], name: "index_statistics_on_story_id"

  create_table "stories", force: true do |t|
    t.text     "story_content", null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_actions", force: true do |t|
    t.integer  "story_id",    null: false
    t.integer  "node_id"
    t.integer  "user_id"
    t.integer  "action_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_actions", ["node_id"], name: "index_user_actions_on_node_id"
  add_index "user_actions", ["story_id"], name: "index_user_actions_on_story_id"
  add_index "user_actions", ["user_id"], name: "index_user_actions_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username"

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
