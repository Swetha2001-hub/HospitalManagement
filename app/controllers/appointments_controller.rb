class AppointmentsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_departments, only: [:new, :available_doctors, :create]

  def new  
    
    @appointment = Appointment.new
  end
  def index
    if current_user.role == "doctor"
      @appointments = Appointment.where(doctor_id: current_user.doctor.id)
    elsif current_user.role == "patient"
      @appointments = Appointment.where(patient_id: current_user.patient.id)
    else
      redirect_to root_path, alert: "You are not authorized to view this page."
    end
  
    puts "Debug: Appointments loaded -> #{@appointments.inspect}" # Debugging line
  end
  
 # app/controllers/appointments_controller.rb

 def accept
  @appointment = Appointment.find(params[:id])
  @appointment.update(status: 'accepted')

  # Redirect doctor to patient profile to enter medical details
  redirect_to patient_profile_path(@appointment.patient), notice: "Appointment accepted. You can now enter the patient's medical details."
end

  
  
  def available_doctors
    @department = Department.find_by(id: params[:department_id])
  
    if @department
      @doctors = @department.doctors.includes(:availabilities)
  
      respond_to do |format|
        format.html { render partial: "appointments/doctor_selection", locals: { doctors: @doctors } }
        format.json { render json: @doctors }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_appointment_path, alert: "Department not found." }
        format.json { render json: { error: "Department not found" }, status: :not_found }
      end
    end
  end
  
  def available_slots
    @doctor = Doctor.find_by(id: params[:doctor_id])
  
    if @doctor
      @slots = @doctor.availabilities
      @appointment = Appointment.new
  
      respond_to do |format|
        format.html { render partial: "appointments/slot_selection", locals: { slots: @slots, appointment: @appointment } }
        format.json { render json: @slots }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_appointment_path, alert: "Doctor not found." }
        format.json { render json: { error: "Doctor not found" }, status: :not_found }
      end
    end
  end
  
  def create
    
    @appointment = current_user.patient.appointments.build(appointment_params)
    @appointment.date = params[:appointment][:date] 
    @appointment.status = "pending" unless @appointment.status.present?
    puts "Debug: Appointment status (create) -> #{@appointment.status}" # Debugging line
    if @appointment.save
  
      redirect_to patient_dashboard_path(params[:appointment][:doctor_id]), notice: "Appointment booked successfully!"
    else
      flash[:alert] = "Failed to book appointment. Errors: #{@appointment.errors.full_messages.join(", ")}"
      render :new  
    end
  end
  

  def patient_profile
    @appointment = Appointment.find(params[:id])
    @patient = @appointment.patient
    @medical_record = @patient.medical_records.new
  end
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to patient_dashboard_path, notice: "Appointment canceled successfully."
  end
  

  private

  
  def appointment_params
    params.require(:appointment).permit(:doctor_id, :date,:status)
  end

  def set_departments
    @departments = Department.all
  end
end
