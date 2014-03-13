class RemoveReviewerFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :reviewer, :string
    remove_column :reviews, :reviewers, :string
  end
end
