class AvailabilitiesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin
    before_action :set_availability, only: [:destroy]
    def index
      @doctors = Doctor.includes(:availabilities).all
    end
  
    def destroy
      @availability.destroy
      respond_to do |format|
        format.html { redirect_to request.referer || doctors_path, notice: "Slot deleted successfully." } # Fallback for non-JS users
        format.js   
      end
    end
    def new
      @doctor = Doctor.find(params[:doctor_id])
      @availability = @doctor.availabilities.build
    end
  
    def create
      @doctor = Doctor.find(params[:doctor_id])
      @availability = @doctor.availabilities.build(availability_params)
  
      if @availability.save
        redirect_to doctors_path, notice: "Availability slot added successfully."
      else
        flash[:alert] = "Failed to add availability: #{@availability.errors.full_messages.join(', ')}"
        render :new
      end
    end
  
    private
  
    def availability_params
      params.require(:availability).permit(:start_time, :end_time, :slot_duration)
    end


    def set_availability
      @availability = Availability.find(params[:id])
    end
  
    def authorize_admin
      unless current_user.admin?
        redirect_to root_path, alert: "Access denied! Only admins can manage availability."
      end
    end
  end
  