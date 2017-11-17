class CreatePatientHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_histories do |t|
      t.text :symptoms
      t.text :diagnosis
      t.text :tests
      t.text :physicals
      t.text :prescription

      t.timestamps
    end
  end
end
