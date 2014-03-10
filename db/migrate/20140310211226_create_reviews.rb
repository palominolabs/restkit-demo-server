class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :reviewer
      t.integer :rating
      t.text :comment
      t.references :beer, index: true

      t.timestamps
    end
  end
end
