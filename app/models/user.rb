class User < ApplicationRecord
  has_one :contractor, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, uniqueness: true
end
