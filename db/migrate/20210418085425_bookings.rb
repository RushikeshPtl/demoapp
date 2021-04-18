class Bookings < ActiveRecord::Migration[6.1]
  def self.up
    create_table :bookings do |t|
      t.column :bus_id, :integer
      t.column :user_id, :integer
      t.column :cost_paid, :float
      t.column :seats_booked, :integer
      t.column :created_at, :timestamp
      t.column :is_canceled, :integer
    end
  end

  def self.down
    drop_table :bookings
  end
end
