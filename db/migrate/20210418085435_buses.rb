class Buses < ActiveRecord::Migration[6.1]
  def self.up
    create_table :buses do |t|
      t.column :route_name, :string
      t.column :trip_start_time, :datetime
      t.column :trip_end_time, :datetime
      t.column :ticket_price, :float
      t.column :seat_capacity, :integer
    end
  end

  def self.down
    drop_table :buses
  end
end