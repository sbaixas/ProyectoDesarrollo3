class CreateSurveyStates < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_states do |t|
      t.references :user, foreign_key: true
      t.references :survey, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
