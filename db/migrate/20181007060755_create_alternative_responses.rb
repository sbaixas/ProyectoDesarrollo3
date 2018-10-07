class CreateAlternativeResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :alternative_responses do |t|
      t.references :user, foreign_key: true
      t.references :alternative, foreign_key: true

      t.timestamps
    end
  end
end
