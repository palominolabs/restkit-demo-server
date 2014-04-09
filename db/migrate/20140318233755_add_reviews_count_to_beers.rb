class AddReviewsCountToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :reviews_count, :integer
  end
end
