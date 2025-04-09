class DoctorsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_doctor, only: [:show]
  def index
    if current_user.admin?
      @doctors = Doctor.all
    else
      @doctors = Doctor.where(user_id: current_user.id) 
    end
  end
  def update
    if @doctor.update(doctor_params)
      redirect_to doctor_path(@doctor), notice: "Doctor updated successfully."
    else
      render :edit, status: :unprocessable_entity
    
    end
  end
  def edit
    @doctor = Doctor.find(params[:id])
  end

  def new
    @doctor = Doctor.new
   
  end
  def show
    @doctor = current_user.doctor
  end
  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update(doctor_params)
      redirect_to doctors_path, notice: "Doctor updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    redirect_to doctors_path, notice: "Doctor deleted successfully."
  end

  def create
  @doctor = Doctor.new(doctor_params)  

  ActiveRecord::Base.transaction do
    user_params = params.require(:doctor).permit(:email, :password, :password_confirmation)
    
    user = User.new(user_params.merge(role: :doctor))

    if user.save
      @doctor.user = user

      if @doctor.save
        redirect_to doctors_path, notice: "Doctor created successfully."
      else
        flash[:alert] = "Doctor profile could not be created: #{@doctor.errors.full_messages.join(', ')}"
        render :new, status: :unprocessable_entity
      end
    else
      flash[:alert] = "User could not be created: #{user.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end
end


  
  private

  def doctor_params
    params.require(:doctor).permit(:first_name, :middle_name, :last_name, :dob, 
                                   :contact_number, :email, :nationality, :gender, 
                                   :qualifications, :experience, :photo, :department_id)
  end
  

  def authorize_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Access denied! Only admins can manage doctors."
    end
  end
  def authorize_doctor
    if current_user.doctor?
      redirect_to doctor_path(current_user.doctor) unless current_user.admin?
    end
  end
end