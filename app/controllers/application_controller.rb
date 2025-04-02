# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    if resource.admin?
      dashboard_path  # Redirect Admin to Dashboard
    elsif resource.doctor?
      doctors_path  # Redirect Doctor to Doctors Page
    elsif resource.patient?
      
      patient_dashboard_path # Redirect Patient to Home page or any specific page
    else
      root_path  # Default fallbacka
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role]) # Ensure role is permitted
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
end
