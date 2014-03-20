class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :type
      t.references :beer, index: true
      t.references :user, index: true
      t.references :review, index: true

      t.timestamps
    end
  end
end
