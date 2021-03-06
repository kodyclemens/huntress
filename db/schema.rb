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

ActiveRecord::Schema.define(version: 20_190_106_205_847) do
  create_table 'jobs', force: :cascade do |t|
    t.string   'title'
    t.string   'company',     default: ''
    t.string   'location',    default: ''
    t.string   'description', default: ''
    t.boolean  'applied',     default: false
    t.integer  'user_id'
    t.text     'note', default: 'Edit to add your own note.'
    t.datetime 'created_on'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username'
    t.string 'email'
    t.string 'password_digest'
    t.string 'role', default: 'user'
  end
end
