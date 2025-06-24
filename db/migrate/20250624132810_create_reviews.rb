class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.string :user
      t.integer :stars
      t.text :review_text
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
