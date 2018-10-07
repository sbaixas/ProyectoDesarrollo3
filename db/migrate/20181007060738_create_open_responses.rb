class CreateOpenResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :open_responses do |t|
      t.references :user, foreign_key: true
      t.references :open_question, foreign_key: true
      t.text :answer

      t.timestamps
    end
  end
end
