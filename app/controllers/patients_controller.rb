require "sms_worker"
class PatientsController < ApplicationController
  layout 'dashboard'
  before_action :set_patient, only: [:show, :edit, :update, :destroy] 
  before_action :authenticate_user!

  def index
  	@patients = User.where(user_type: 'Patient')
  end

  def show
  end

  def edit
    @patient = User.find(params[:id])
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

  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to "/patients/#{@patient.id}/details", notice: 'Patient history was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_in
    
  end

  def verify_patient
    v = Verification.where(phone_number: session[:phone_number]).last # it shows all the numbers then picks the last one 
    if !v.nil? && v.verification_code == params[:verification_code].strip
      # This means the verification code exists in the DB and matches the verification code typed in by the receptionist
      # Check whether patient with the verified phone number exists in the db.
      u = User.find_by(phone_number: session[:phone_number])
      if u.nil?
        u = User.new(phone_number: session[:phone_number], password: '12345678', email: "#{SecureRandom.hex}@gmail.com", user_type: 'Patient')
        u.save!
        redirect_to "/patients/#{u.id}/edit"
      else
        redirect_to "/patients/#{u.id}/details"
      end

      # If it does:
      # Redirect to the patient's history page
      # If not, create a record for it:

    else
      # This means the verification code doesn't exist in the DB
      redirect_to '/patients/verify', notice: 'Wrong code. Try again.'
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
    session[:phone_number] = params[:phone_number] # We saving the last phone number in the session cookie in the browser
    logger.info ">>>> The code is #{n}"
    SmsWorker.perform_async(params[:phone_number], n)
    redirect_to "/patients/verify"
  end

  def details
    # Check whether whoever is trying to access this page is a doctor or a receptionist
    # If it is a patient, we only allow them to access if it is their own details page
    # Check the time of the last verification done for this patient. If it is more than an hour ago, we ask them to verify again
    @patient=User.find_by(id: params[:id])
    if current_user.user_type == 'Patient'
      if current_user != @patient
        redirect_to '/error'
      end
    else
      v = Verification.where(phone_number: @patient.phone_number).last
      if !(!v.nil? && Time.now - v.created_at <= 1.hour)
        session[:phone_number] = @patient.phone_number
        redirect_to '/patients/check_in', notice: 'Timed out! You need to reverify this patient again.'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:user).permit(:name, :email, :id_number, :phone_number, :dob, :gender)
    end  
end
