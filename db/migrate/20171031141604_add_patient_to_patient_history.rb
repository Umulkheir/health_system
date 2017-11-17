class AddPatientToPatientHistory < ActiveRecord::Migration[5.0]
  def change
    add_column :patient_histories, :patient_id, :integer
    add_column :patient_histories, :doctor_id, :integer
  end
end
