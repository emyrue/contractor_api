class AddContractorRefToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :contractor, null: false, foreign_key: true
  end
end
