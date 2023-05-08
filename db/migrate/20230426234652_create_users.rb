class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :role, default: "user"
      t.boolean :is_contractor, default: false

      t.timestamps
    end
  end
end
