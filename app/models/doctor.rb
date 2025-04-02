class Doctor < ApplicationRecord
  belongs_to :user
  belongs_to :department
  has_many :appointments
  has_many :patients, through: :appointments
  has_one_attached :photo
  serialize :available_slots, coder: JSON
  accepts_nested_attributes_for :user  
  #validates :user_id, uniqueness: true
  has_many :availabilities, dependent: :destroy  
  has_many :medical_records
  validates :first_name, :last_name, :dob, :contact_number, :gender, 
  :qualifications, :experience, presence: true
  def full_name
    "#{first_name} #{middle_name} #{last_name}".strip
  end
end
