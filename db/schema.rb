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

ActiveRecord::Schema.define(:version => 20100918185425) do

  create_table "properties", :force => true do |t|
    t.string   "secondary_address"
    t.string   "primary_address"
    t.string   "street"
    t.string   "town"
    t.string   "band"
    t.string   "longitude"
    t.string   "latitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taxbands", :force => true do |t|
    t.string   "name"
    t.integer  "lower_limit"
    t.integer  "upper_limit"
    t.decimal  "charge",            :precision => 9, :scale => 2
    t.date     "start_date"
    t.date     "end_date"
    t.date     "market_value_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
