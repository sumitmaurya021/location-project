class CreateEnquiries < ActiveRecord::Migration[8.0]
  def change
    create_table :enquiries do |t|
      t.string :your_name
      t.string :your_email
      t.string :phone_no
      t.text :location_enquiry
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
