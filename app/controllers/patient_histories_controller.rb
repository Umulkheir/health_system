class PatientHistoriesController < ApplicationController
  before_action :set_patient_history, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  # GET /patient_histories
  # GET /patient_histories.json
  def index
    @patient_histories = PatientHistory.all
  end

  # GET /patient_histories/1
  # GET /patient_histories/1.json
  def show
  end

  # GET /patient_histories/new
  def new
    @patient_history = PatientHistory.new
  end

  # GET /patient_histories/1/edit
  def edit
  end

  # POST /patient_histories
  # POST /patient_histories.json
  def create
    @patient_history = PatientHistory.new(patient_history_params)
    @patient_history.patient_id = params[:patient]

    respond_to do |format|
      if @patient_history.save
        format.html { redirect_to "/patients/#{params[:patient]}/details", notice: 'Patient history was successfully created.' }
        format.json { render :show, status: :created, location: @patient_history }
      else
        format.html { render :new }
        format.json { render json: @patient_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patient_histories/1
  # PATCH/PUT /patient_histories/1.json
  def update
    respond_to do |format|
      if @patient_history.update(patient_history_params)
        format.html { redirect_to @patient_history, notice: 'Patient history was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient_history }
      else
        format.html { render :edit }
        format.json { render json: @patient_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patient_histories/1
  # DELETE /patient_histories/1.json
  def destroy
    @patient_history.destroy
    respond_to do |format|
      format.html { redirect_to patient_histories_url, notice: 'Patient history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient_history
      @patient_history = PatientHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_history_params
      params.require(:patient_history).permit(:symptoms, :diagnosis, :tests, :physicals, :prescription, :comment)
    end
end
