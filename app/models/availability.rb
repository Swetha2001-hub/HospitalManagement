class Availability < ApplicationRecord
  belongs_to :doctor
  validates :start_time, :end_time, :slot_duration, presence: true
end
