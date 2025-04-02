class Patient < ApplicationRecord
  belongs_to :user
  has_one :room, foreign_key: "patient_id", dependent: :nullify
  accepts_nested_attributes_for :user
  has_many :appointments
  validates :admitted_at, presence: true, allow_nil: true
  
  def full_name
    "#{first_name} #{last_name}"
  end
  has_one_attached :photo
  
  has_many :medical_records
  # validates :first_name, :last_name, :date_of_birth, :contact_number, :gender, :blood_group, presence: true
  def admitted?
    medical_records.exists?(admitted: true) 
  end
  
end
