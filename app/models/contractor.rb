class Contractor < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :reservations, dependent: :destroy
  validates :user, uniqueness: true
  validates :name, uniqueness: true
  validates :rate, numericality: { :greater_than => 0 }
end
