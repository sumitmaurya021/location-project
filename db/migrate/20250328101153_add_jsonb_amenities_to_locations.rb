class AddJsonbAmenitiesToLocations < ActiveRecord::Migration[8.0]
  def change
    add_column :locations, :general_amenities, :jsonb, default: []
    add_column :locations, :interior_amenities, :jsonb, default: []
    add_column :locations, :exterior_amenities, :jsonb, default: []
    add_column :locations, :utility_amenities, :jsonb, default: []
    add_column :locations, :film_specific_amenities, :jsonb, default: []
    add_column :locations, :permissions, :jsonb, default: []
    add_column :locations, :accessibilities, :jsonb, default: []
    add_column :locations, :suitable_for, :jsonb, default: []
    add_column :locations, :public_facility, :jsonb, default: []
  end
end
