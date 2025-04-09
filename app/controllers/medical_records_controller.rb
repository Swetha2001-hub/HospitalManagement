class MedicalRecordsController < ApplicationController
  require 'prawn'

  before_action :set_patient
  before_action :set_appointment, only: [:create]

  def create
    @medical_record = @patient.medical_records.build(medical_record_params)
    @medical_record.doctor_id ||= @appointment&.doctor_id
    @medical_record.appointment_id ||= params[:appointment_id] || @appointment&.id
  
    if params[:medical_record][:admitted] == "1" && params[:bed_id].present?
      @medical_record.admitted = true
  
      
      selected_bed = Bed.find_by(id: params[:bed_id], status: "available")
  
      if selected_bed
      
        selected_bed.update(status: "occupied", patient_id: @patient.id)
  
        
        room = selected_bed.room
        room.update(status: "occupied", patient_id: @patient.id)
  
        
        available_beds = room.beds.where(status: "available").count
        occupied_beds = room.beds.where(status: "occupied").count
  
       
        room.update(status: available_beds.zero? ? "fully_occupied" : "partially_occupied")
  
       
        @patient.update(admitted_at: Time.current)
      else
        flash[:alert] = "Selected bed is not available."
        redirect_to patient_profile_path(@patient) and return
      end
    end
  
    if @medical_record.save
      redirect_to patient_profile_path(@patient), notice: "Medical record saved successfully."
    else
      flash.now[:alert] = @medical_record.errors.full_messages.join(", ")
      render 'patients/profile', status: :unprocessable_entity
    end
  end
  
  
  
  
    

  def show
    @medical_record = MedicalRecord.new
    @rooms = Room.includes(:beds) 
    @beds = Bed.where(status: "available") 
  end
  
  
  

  def download_pdf
    @medical_record = MedicalRecord.find(params[:id])
    patient = @medical_record.patient

    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "Patient Medical Record", size: 20, style: :bold
        pdf.move_down 20

        
        pdf.text "Patient Name: #{patient.full_name}"
        pdf.text "Date of Birth: #{patient.date_of_birth}"
        pdf.text "Contact: #{patient.contact_number}"
        pdf.text "Gender: #{patient.gender}"
        pdf.text "Blood Group: #{patient.blood_group}"
        pdf.move_down 20

        
        pdf.text "Doctor: #{@medical_record.doctor.full_name}"
        pdf.text "Condition: #{@medical_record.condition}"
        pdf.text "Medication Given: #{@medical_record.medication}"
        pdf.text "Comments: #{@medical_record.comments}"
        pdf.text "Admitted: #{@medical_record.admitted ? 'Yes' : 'No'}"
        pdf.move_down 20

        send_data pdf.render, filename: "Medical_Record_#{patient.id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end


  def available_rooms
    patient = Patient.find(params[:patient_id])
    appointment = patient.appointments.last  
    doctor = appointment.doctor
    department = doctor.department
    available_rooms = department.rooms.where(status: "available")
  
    render json: available_rooms.select(:id, :room_number)
  end
  

  private

  
  def medical_record_params
    params.require(:medical_record).permit(:patient_id, :doctor_id, :appointment_id, :comments, :condition, :medication, :admitted)
  end

  def set_patient
    @patient = Patient.find_by(id: params[:patient_id]) || 
               Patient.find_by(id: params.dig(:medical_record, :patient_id)) || 
               MedicalRecord.find_by(id: params[:id])&.patient

    unless @patient
      redirect_to root_path, alert: "Patient not found."
    end
  end

  def set_appointment
    @appointment = Appointment.find_by(id: params.dig(:medical_record, :appointment_id)) ||
                   Appointment.find_by(patient_id: @patient.id)

    unless @appointment
      flash[:alert] = "No appointment found for this patient."
      redirect_to patient_profile_path(@patient)
    end
  end
end
