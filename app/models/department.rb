class Department < ApplicationRecord
    has_many :doctors
    has_many :rooms
    validates :name, presence: true
  end
  
