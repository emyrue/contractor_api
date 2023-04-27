class Job < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :name, uniqueness: true
  validates :complete_time, numericality: { :greater_than => 0 }
end
