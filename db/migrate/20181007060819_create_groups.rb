class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :tag
      t.boolean :subscription

      t.timestamps
    end
  end
end
