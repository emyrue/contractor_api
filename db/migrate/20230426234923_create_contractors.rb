class CreateContractors < ActiveRecord::Migration[7.0]
  def change
    create_table :contractors do |t|
      t.string :job_title
      t.integer :rate
      t.text :bio

      t.timestamps
    end
  end
end
