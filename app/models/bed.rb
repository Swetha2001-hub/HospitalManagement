class Bed < ApplicationRecord
  belongs_to :room
  
  validates :bed_number, presence: true
  scope :available, -> { where(status: "available") }

  
end
