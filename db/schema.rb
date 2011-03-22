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

ActiveRecord::Schema.define(:version => 20110322151102) do

  create_table "players", :force => true do |t|
    t.string   "name"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "players_positions", :id => false, :force => true do |t|
    t.integer "player_id"
    t.integer "position_id"
  end

  add_index "players_positions", ["player_id"], :name => "index_players_positions_on_player_id"
  add_index "players_positions", ["position_id"], :name => "index_players_positions_on_position_id"

  create_table "positions", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions", ["abbr"], :name => "index_positions_on_abbr"

  create_table "projections", :force => true do |t|
    t.integer  "player_id"
    t.integer  "year"
    t.string   "site"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.integer  "FPTS"
    t.string   "INN"
    t.string   "GS"
    t.string   "QS"
    t.string   "CG"
    t.string   "W"
    t.string   "L"
    t.string   "S"
    t.string   "BS"
    t.string   "K"
    t.string   "BBI"
    t.string   "HA"
    t.string   "ERA"
    t.string   "WHIP"
    t.string   "AB"
    t.string   "R"
    t.string   "H"
    t.string   "H1B"
    t.string   "H2B"
    t.string   "H3B"
    t.string   "HR"
    t.string   "RBI"
    t.string   "BB"
    t.string   "KO"
    t.string   "SB"
    t.string   "CS"
    t.string   "BA"
    t.string   "OBP"
    t.string   "SLG"
  end

  add_index "projections", ["player_id"], :name => "index_projections_on_player_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbr"
  end

end
