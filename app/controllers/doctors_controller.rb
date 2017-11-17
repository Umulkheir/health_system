class DoctorsController < ApplicationController
  layout 'dashboard'
  def index
    @doctors = User.where(user_type: 'Doctors')
  end

  def show
  end

  def edit
  end

  def new
    @doctor = User.new
  end

  def create
    @doctor = User.new(patient_params)
    @doctor.user_type = 'Doctor'

    respond_to do |format|
      if @doctor.save
        format.html { redirect_to @doctor, notice: 'doctor was successfully created.' }
        format.json { render :show, status: :created, location: @doctor }
      else
        format.html { render :new }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
 
  end
end
