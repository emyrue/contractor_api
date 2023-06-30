class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.string :address
      t.text :job_description
      t.boolean :user_cancelled, default: false
      t.boolean :contractor_cancelled, default: false
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
