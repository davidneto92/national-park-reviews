class CreateParkVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :park_votes do |t|
      t.integer :choice
      # range is -1, 0, 1

      t.references :park, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
