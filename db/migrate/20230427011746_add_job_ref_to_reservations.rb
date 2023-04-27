class AddJobRefToReservations < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :job, null: false, foreign_key: true
  end
end
