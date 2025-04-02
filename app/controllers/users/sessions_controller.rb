class Users::SessionsController < Devise::SessionsController
    def new
      super do
        if params[:role] == "doctor"
          flash[:notice] = "Please log in as a Doctor."
        elsif params[:role] == "admin"
          flash[:notice] = "Please log in as an Admin."
        end
      end
    end
    def after_sign_in_path_for(resource)
      case resource.role
      when 'admin'
        admin_root_path
      when 'doctor'
        doctor_dashboard_path
      when 'patient'
        patient_dashboard_path(resource.id)
      else
        root_path
      end
    end
  end
  