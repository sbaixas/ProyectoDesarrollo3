class CreateMultipleResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :multiple_responses do |t|
      t.references :user, foreign_key: true
      t.references :multiple_alternative, foreign_key: true

      t.timestamps
    end
  end
end
