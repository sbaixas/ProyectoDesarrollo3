class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :age, :integer
    add_column :users, :gender, :boolean
    add_column :users, :rut, :string
    add_column :users, :active, :boolean
    add_column :users, :accumulated_score, :integer
    add_reference :users, :career, index: true

  end
end
