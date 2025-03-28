class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.string :category
      t.string :sub_category
      t.string :general_amenities
      t.string :interior_ameneties
      t.string :exterior_ameneties
      t.string :utility_ameneties
      t.integer :max_people_allowed
      t.string :film_specific_ameneties
      t.string :map_link
      t.string :accessibilities
      t.string :permission
      t.boolean :staying_facility
      t.string :property_type
      t.string :address
      t.string :country
      t.string :state
      t.string :city
      t.integer :pincode
      t.string :description
      t.string :terms_and_conditions
      t.string :remarks
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
