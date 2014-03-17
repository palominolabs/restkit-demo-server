class Beer < ActiveRecord::Base
  belongs_to :brewery, counter_cache: true
  has_many :reviews, dependent: :destroy
  has_many :reviewers, through: :reviews, class_name: 'User', source: :user

  validates_presence_of :name
  validates_presence_of :brewery

  def average_rating
    reviews.average(:rating).round(1) if reviews.any?
  end
end
