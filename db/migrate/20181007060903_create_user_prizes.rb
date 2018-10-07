class CreateUserPrizes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_prizes do |t|
      t.references :user, foreign_key: true
      t.references :prize, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
