class User < ApplicationRecord
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 
  enum :role, { admin: 0, doctor: 1, patient: 2 }

  has_one :doctor
  has_one :patient, dependent: :destroy 

  validates :role, presence: true
  validates :email, presence: true, uniqueness: true

  before_validation :set_default_role, on: :create  

  def admin?
    role == "admin"
  end

  def doctor?
    role == "doctor" && doctor.present?
  end

  def patient?
    role == "patient"
  end

  private

  def set_default_role
    if self.new_record? && self.role.blank? && self.patient.present?
      self.role = "patient"  
    end
  end
end
