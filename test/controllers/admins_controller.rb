class AdminsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin
  
    def dashboard
      @departments = Department.all
      @doctors = Doctor.all
      @patients = Patient.all
    end
  
    def create_department
      @department = Department.new(department_params)
      if @department.save
        redirect_to admin_dashboard_path, notice: "Department created successfully!"
      else
        render :new
      end
    end
  
    def create_doctor
      user = User.new(user_params.merge(role: "doctor"))
      if user.save
        Doctor.create(user: user, department_id: params[:department_id])
        redirect_to admin_dashboard_path, notice: "Doctor added successfully!"
      else
        render :new
      end
    end
  
    private
  
    def authorize_admin
      redirect_to root_path, alert: "Access denied" unless current_user.admin?
    end
  
    def department_params
      params.require(:department).permit(:name)
    end
  
    def user_params
      params.require(:user).permit(:email, :password, :name)
    end
  end
  