class Room < ApplicationRecord
  belongs_to :patient, optional: true
  belongs_to :department
  has_many :beds, dependent: :destroy
  accepts_nested_attributes_for :beds

  validates :room_number, presence: true
  validates :status, inclusion: { in: ["available", "occupied"] }

  scope :available, -> { where(status: "available") }

 


  def available_beds_count
    beds.where(status: "available").count
  end
  def occupied_beds_count
    beds.where(status: "occupied").count
  end

  def assigned_patient_name
    patient.present? ? "#{patient.first_name} #{patient.last_name}" : "Not Assigned"
  end

  
end
