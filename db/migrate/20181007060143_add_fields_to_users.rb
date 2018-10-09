class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthdate, :datetime
    add_column :users, :gender, :string
    add_column :users, :rut, :string
    add_column :users, :active, :boolean, default: false
    add_column :users, :accumulated_score, :integer, default: 0
    add_reference :users, :career, index: true

  end
end
