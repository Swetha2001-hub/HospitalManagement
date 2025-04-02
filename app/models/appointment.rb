class Appointment < ApplicationRecord
  has_one :medical_record
  belongs_to :doctor
  belongs_to :patient
  validates :date, presence: true
  #validates :appointment_time, presence: true
  validates :status, inclusion: { in: ["pending", "accepted", "cancelled"] }

end
