class PatientsController < ApplicationController
  #before_action :set_patient, only: [:show, :admit_patient]


  def admit
    if params[:room_id].present? && params[:bed_id].present?
      room = Room.find_by(id: params[:room_id])
      bed = Bed.find_by(id: params[:bed_id])

      if room && bed && bed.status == "available"
        @patient.update(room_id: room.id, bed_id: bed.id, admitted_at: Time.current)

     
        room.update(patient_id: @patient.id)
        bed.update(status: "occupied", patient_id: @patient.id)

        redirect_to patient_path(@patient), notice: "Patient admitted successfully!"
      else
        redirect_to patient_path(@patient), alert: "Invalid room or bed selection."
      end
    else
      redirect_to patient_path(@patient), alert: "Room and bed selection required!"
    end
  end


  
  def dashboard
    @patient = current_user.patient
  
    if @patient.nil?
      redirect_to root_path, alert: "Patient not found. Please complete registration."
    else
      @medical_records = @patient.medical_records
    end
  end
  
  
  def profile
    @patient = Patient.find(params[:id])
    @medical_record = MedicalRecord.new
  end

  def show
    @patient = Patient.find(params[:id])
  end

  
  def new
    
    @patient = Patient.new
    @patient.build_user
  end


  def create
    @patient = Patient.new(patient_params)

    
    if @patient.user
      @patient.user.role = 'patient'  
    end

    if @patient.save
      sign_in(@patient.user) 
      redirect_to patient_dashboard_path, notice: "Patient registered successfully."
    else
      puts @patient.errors.full_messages 
      puts @patient.user.errors.full_messages if @patient.user
      flash[:alert] = "Failed to register patient. Please check your details."
      render :new
    end
  end
  def discharge
    if @patient.room
      @patient.room.update(patient_id: nil, status: "available")
    end
    flash[:notice] = "Patient discharged successfully."
    redirect_to patient_profile_path(@patient)
  end

  def edit
    @patient = Patient.find(params[:id]) 
  end
  
  def update
    @patient = Patient.find(params[:id]) 
    if @patient.update(patient_params)
      flash[:notice] = "Profile updated successfully!"
      redirect_to @patient
    else
      flash[:alert] = "Failed to update profile. Please check the errors."
      render :edit
    end
  end
  
  
  
  
  
  
  
  

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :date_of_birth, :contact_number, 
                                    :gender, :blood_group, :address, :photo,
                                    user_attributes: [:email, :password, :password_confirmation]).tap do |params|
      params[:user_attributes][:role] = 'patient' if params[:user_attributes] 
    end
  end
  
  def user_params
    params.require(:patient).require(:user_attributes).permit(:email, :password, :password_confirmation)
  end


  def set_patient
    @patient = Patient.find(params[:id])
  end
end
