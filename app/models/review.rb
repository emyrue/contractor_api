class Review < ApplicationRecord
  belongs_to :user
  belongs_to :contractor
  has_many :likes, dependent: :destroy
  validates :rating, numericality: { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5 }
end
