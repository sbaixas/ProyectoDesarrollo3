class CreateFilters < ActiveRecord::Migration[5.2]
  def change
    create_table :filters do |t|
      t.references :survey, foreign_key: true
      t.text :query

      t.timestamps
    end
  end
end
