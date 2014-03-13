class Beer < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :reviewers, through: :reviews, class_name: 'User', source: :user

  validates_presence_of :name
  validates_presence_of :brewery

  def average_rating
    reviews.average(:rating)
  end

  def has_been_reviewed_by(user)
    reviewers.where(id: user.id).any?
  end
end
