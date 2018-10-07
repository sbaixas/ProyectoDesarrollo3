class CreateMultipleQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :multiple_questions do |t|
      t.references :survey, foreign_key: true
      t.text :statement

      t.timestamps
    end
  end
end
