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

ActiveRecord::Schema.define(:version => 20130124164658580090) do

  create_table "attachments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "classified_id"
  end

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "authentications", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "oauth_token"
    t.string   "oauth_secret"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identifier"
    t.integer  "parent_id"
  end

  add_index "categories", ["identifier"], :name => "index_categories_on_identifier"

  create_table "classifieds", :force => true do |t|
    t.string   "kind"
    t.string   "title"
    t.text     "description"
    t.decimal  "price",            :precision => 8, :scale => 2
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identifier"
    t.integer  "main_category_id"
    t.integer  "sub_category_id"
    t.integer  "country_id"
    t.string   "tags"
    t.string   "phone"
    t.string   "email"
    t.integer  "currency_id"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
  end

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.float    "ratio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
  end

  create_table "translation_center_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "translation_center_translation_keys", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "last_accessed"
    t.string   "en_status",     :default => "untranslated"
    t.string   "ar_status",     :default => "untranslated"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "translation_center_translations", :force => true do |t|
    t.integer  "translation_key_id"
    t.string   "value"
    t.string   "lang"
    t.integer  "user_id"
    t.string   "status",             :default => "pending"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "phone"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
