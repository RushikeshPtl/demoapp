# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_18_085435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer "bus_id"
    t.integer "user_id"
    t.float "cost_paid"
    t.integer "seats_booked"
    t.datetime "created_at"
    t.integer "is_canceled"
  end

  create_table "buses", force: :cascade do |t|
    t.string "route_name"
    t.datetime "trip_start_time"
    t.datetime "trip_end_time"
    t.float "ticket_price"
    t.integer "seat_capacity"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "city", default: "", null: false
    t.string "registration_country"
    t.string "contact_number"
    t.integer "status_active", default: 0, null: false
    t.datetime "date_created"
    t.datetime "date_modified"
    t.datetime "date_deleted"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
