class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :title, null: false
      t.string :body, null: false
      t.date :visit_date

      t.integer :vote_score, default: 0

      t.references :park, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
