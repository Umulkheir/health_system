class PatientsController < ApplicationController
  layout 'dashboard'
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

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
        u = User.new(phone_number: session[:phone_number], password: '12345678', email: "#{SecureRandom.hex}@gmail.com")
        u.save!
      end
      redirect_to "/patients/#{u.id}/edit"

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
    # HTTParty.post('http://w3.synqafrica.com/api/messages/send', body: {api_key: 'c8de764e5da0df4449b401869e0960a7', phone_number: params[:phone_number], text: "Hello. Your verification code is #{n}."})
    redirect_to "/patients/verify?code=#{n}"
  end

  def details
    @patient=User.find_by(id: params[:id])
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
