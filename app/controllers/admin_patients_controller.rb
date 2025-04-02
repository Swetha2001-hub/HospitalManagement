class AdminPatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @patients = Patient.all
  end

  def show
    @patient = Patient.find(params[:id])
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "Access Denied!" unless current_user.admin?
  end
end
