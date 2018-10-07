class CreateSurveyCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_categories do |t|
      t.references :survey, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
