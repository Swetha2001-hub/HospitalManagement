class MedicalRecord < ApplicationRecord
  belongs_to :doctor
  belongs_to :appointment
  belongs_to :patient
  has_one_attached :report  
  validates :comments, :condition, :medication, presence: true
  has_one_attached :supporting_document
  attribute :recommend_admission, :boolean, default: false
  validates :admitted, inclusion: { in: [true, false] } 
end
