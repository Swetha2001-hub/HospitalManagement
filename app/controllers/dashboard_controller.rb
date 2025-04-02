class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin
  
    def index
      # Dashboard logic here
    end
  
    private
  
    def authorize_admin
      unless current_user.admin?
        redirect_to root_path, alert: "Access denied! Only admins can manage this page."
      end
    end
  end
  