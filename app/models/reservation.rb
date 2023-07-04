class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :contractor
  validate :no_overlap_for_same_contractor
  # validates :job_description, presence: true

  def no_overlap_for_same_contractor
    overlapping_reservations = Reservation.where.not(id:)
      .where(contractor_id:)
      .where(approved: true)
      .where('(start_date, end_date) OVERLAPS (?, ?)', start_date, end_date)
    return unless overlapping_reservations.exists?

    errors.add(:reservation_period, 'overlaps with existing reservation for the same contractor')
  end
end
