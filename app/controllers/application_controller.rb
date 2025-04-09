
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    if resource.admin?
      dashboard_path 
    elsif resource.doctor?
      doctors_path  
    elsif resource.patient?
      
      patient_dashboard_path 
    else
      root_path  
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role]) 
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
end
