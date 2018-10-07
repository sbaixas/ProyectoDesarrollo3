class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.string :name
      t.text :description
      t.integer :score
      t.datetime :start_date
      t.datetime :end_date
      t.integer :max_answers
      t.integer :min_answers

      t.timestamps
    end
  end
end
