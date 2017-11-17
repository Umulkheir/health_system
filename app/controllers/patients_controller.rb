class PatientsController < ApplicationController
   layout 'dashboard'
  def index
  	@patients = User.where(user_type: 'Patient')
  end

  def show
  end

  def edit
  end 

  def new
  	@patient = User.new
  end

  def create
  	@patient = User.new(patient_params)
  	@patient.user_type = 'Patient'

  	respond_to do |format|
  	  if @patient.save
  	    format.html { redirect_to @patient, notice: 'patient was successfully created.' }
  	    format.json { render :show, status: :created, location: @patient }
  	  else
  	    format.html { render :new }
  	    format.json { render json: @patient.errors, status: :unprocessable_entity }
  	  end
  	end
  end

  def check_in
    
  end

  def verify_patient
    v = Verification.find_by(verification_code: params[:verification_code])
    if v.nil?
      # This means the verification code doesn't exist in the DB
      redirect_to '/patients/verify', notice: 'Wrong code. Try again.'
    else
      # This means the verification code exists in the DB
      render text: 'Succesful'
      # Redirect to the patient's history page
    end
  end

  def verify
    
  end

  def send_sms
    # TODO:
      # 1. Generate random number √
      # 2. Store random number along with the phone number √
        # - Model (Verification):
          # - phone_number
          # - verification_code
          # - verified - boolean

    n = Random.new.rand(1_000_000..10_000_000-1)
    Verification.create(phone_number: params[:phone_number], verification_code: n)
    HTTParty.post('http://w3.synqafrica.com/api/messages/send', body: {api_key: 'c8de764e5da0df4449b401869e0960a7', phone_number: params[:phone_number], text: "Hello. Your verification code is #{n}."})
    redirect_to '/patients/verify'
  end
end
