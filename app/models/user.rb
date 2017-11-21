class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def patient_histories
  	# Find all patient histories that have the patient_id that matches the patient's ID
  	PatientHistory.where(patient_id: id)  	
  end
end
