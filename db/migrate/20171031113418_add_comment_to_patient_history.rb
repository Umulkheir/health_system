class AddCommentToPatientHistory < ActiveRecord::Migration[5.0]
  def change
    add_column :patient_histories, :comment, :text
  end
end
