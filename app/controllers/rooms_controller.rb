class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :update]

  def export_csv
    @rooms = Room.includes(:beds, :department)
  
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["Room Number", "Status", "Assigned Patient & Bed", "Department", "Admitted On"]
  
      @rooms.each do |room|
        if room.beds.exists?(status: "occupied")
          occupied_beds = room.beds.where(status: "occupied").map do |bed|
            patient = Patient.find_by(id: bed.patient_id) 
            patient_name = patient ? "#{patient.first_name} #{patient.last_name}" : "Unknown"
            "#{patient_name} (Bed #{bed.bed_number})"
          end.join("; ")
        else
          occupied_beds = "Not Assigned"
        end
  
        admitted_date = room.beds.exists?(status: "occupied") ? Patient.find_by(id: room.beds.first.patient_id)&.admitted_at&.strftime("%d-%m-%Y %H:%M") : "N/A"
  
        csv << [
          room.room_number,
          room.status.capitalize,
          occupied_beds,
          room.department&.name || "N/A",
          admitted_date
        ]
      end
    end
  
    send_data csv_data, filename: "room_utilization_report_#{Date.today}.csv"
  end
  
  
  def update
    if @room.update(room_params)
      @room.update(status: "Occupied") if @room.patient_id.present?
      redirect_to rooms_path, notice: "Room updated successfully."
    else
      render :edit
    end
  end
  
  def index
    @rooms = Room.includes(:beds, :patient, :department) 
  end

  def show
    @room = Room.includes(:patient, :department, :beds).find(params[:id])
  end

  def new
    @room = Room.new
    2.times { @room.beds.build } 
  end

  def create
    @room = Room.new(room_params)

    if @room.save
     
      if @room.beds.empty?
        3.times do |i|
          @room.beds.create(bed_number: "Bed #{i+1}", status: "available")
        end
      end

      redirect_to rooms_path, notice: "Room successfully added with beds."
    else
      render :new
    end
  end

  def available_beds
    room = Room.find(params[:id])
    available_beds = room.beds.where(status: "available").select(:id, :bed_number)

    if available_beds.any?
      render json: available_beds
    else
      render json: { message: "No available beds" }, status: :not_found
    end
  end

  private

  def set_room
    @room = Room.includes(:patient, :department, :beds).find(params[:id])
  end

  def room_params
    params.require(:room).permit(:room_number, :status, :department_id, beds_attributes: [:id, :bed_number, :status])
  end
end
