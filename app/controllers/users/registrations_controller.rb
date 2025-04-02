# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
    def create
      # Build the user with registration parameters
      build_resource(sign_up_params)
  
      # Automatically assign the 'patient' role
      resource.role = :patient
  
      # Save the user to the database
      if resource.save
        # Sign in the user immediately after registration
        sign_in(resource)
        # Redirect the user to the home page or any other path you prefer
        redirect_to root_path, notice: 'Patient registered successfully!'
      else
        # If there's an error, re-render the registration form with error messages
        clean_up_passwords(resource)
        set_minimum_password_length
        render :new
      end
    end
  end
  