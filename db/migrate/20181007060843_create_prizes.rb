class CreatePrizes < ActiveRecord::Migration[5.2]
  def change
    create_table :prizes do |t|
      t.string :name
      t.text :description
      t.integer :score
      t.boolean :available
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
