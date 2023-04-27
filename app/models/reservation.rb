class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :contractor
  belongs_to :job
  validates :contractor, uniqueness: { scope: :date }
end
