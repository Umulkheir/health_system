class CreateHospitals < ActiveRecord::Migration[5.0]
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :location
      t.text :description
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
