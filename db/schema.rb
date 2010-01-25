# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100125043748) do

  create_table "agencies", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "slug",       :null => false
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug"

  create_table "comments", :force => true do |t|
    t.integer  "post_id",    :null => false
    t.string   "email",      :null => false
    t.string   "name"
    t.string   "body",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "images", :force => true do |t|
    t.integer  "item_id"
    t.string   "file_file_name"
    t.integer  "file_file_size"
    t.string   "file_content_type"
    t.datetime "file_updated_at"
    t.integer  "position",          :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["item_id"], :name => "index_images_on_item_id"

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "images_count", :default => 0
    t.string   "url"
    t.integer  "agency_id"
  end

  create_table "items_skills", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "skill_id"
  end

  add_index "items_skills", ["item_id"], :name => "index_items_skills_on_item_id"
  add_index "items_skills", ["skill_id"], :name => "index_items_skills_on_skill_id"

  create_table "posts", :force => true do |t|
    t.integer  "category_id",                     :null => false
    t.string   "title",                           :null => false
    t.text     "body"
    t.boolean  "published",    :default => false
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "posts", ["category_id"], :name => "index_posts_on_category_id"
  add_index "posts", ["slug"], :name => "index_posts_on_slug"

  create_table "skills", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "slug",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["slug"], :name => "index_skills_on_slug"

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                            :null => false
    t.string   "crypted_password",                 :null => false
    t.string   "password_salt",                    :null => false
    t.string   "persistence_token",                :null => false
    t.integer  "login_count",       :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
