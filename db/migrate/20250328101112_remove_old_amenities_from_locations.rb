class RemoveOldAmenitiesFromLocations < ActiveRecord::Migration[8.0]
  def change
    remove_column :locations, :general_amenities, :string
    remove_column :locations, :interior_ameneties, :string
    remove_column :locations, :exterior_ameneties, :string
    remove_column :locations, :utility_ameneties, :string
    remove_column :locations, :film_specific_ameneties, :string
    remove_column :locations, :permission, :string
    remove_column :locations, :accessibilities, :string
  end
end
