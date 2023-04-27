class AddReviewRefToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :review, null: false, foreign_key: true
  end
end
