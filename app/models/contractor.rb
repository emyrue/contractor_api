class Contractor < ApplicationRecord
  has_one :user
  has_many :reviews, dependent: :destroy
  has_many :reservations, dependent: :destroy
  validates :name, uniqueness: true
  validates :rate, numericality: { greater_than: 0 }
end
