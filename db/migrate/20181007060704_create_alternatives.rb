class CreateAlternatives < ActiveRecord::Migration[5.2]
  def change
    create_table :alternatives do |t|
      t.references :alternative_question, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
