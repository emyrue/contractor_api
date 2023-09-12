class Contractor < ApplicationRecord
  has_one :user
  has_many :reviews, dependent: :destroy
  has_many :reservations, dependent: :destroy
  validates :job_title, presence: true
  validates :rate, numericality: { greater_than: 0 }, presence: true
end
