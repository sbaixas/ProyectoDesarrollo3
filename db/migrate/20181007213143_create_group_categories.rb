class CreateGroupCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :group_categories do |t|
      t.references :group, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
