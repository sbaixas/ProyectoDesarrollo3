class CreateMultipleAlternatives < ActiveRecord::Migration[5.2]
  def change
    create_table :multiple_alternatives do |t|
      t.references :multiple_question, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
