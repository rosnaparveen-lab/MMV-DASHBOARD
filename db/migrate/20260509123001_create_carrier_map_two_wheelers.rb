class CreateCarrierMapTwoWheelers < ActiveRecord::Migration[7.1]
  def change
    create_table :carrier_map_two_wheelers do |t|
      t.string :carrier_vehicle_name
      t.string :carrier_vehicle_code
      t.string :insurance_code
      t.string :vehicle_code
      t.string :vehicle_type
      t.string :fuel_type
      t.integer :cubic_capacity
      t.integer :seating_capacity
      t.string :carrier_make_code
      t.text :additional_info
      t.boolean :declain
      t.references :two_wheeler, foreign_key: true

      t.timestamps
    end
  end
end
