class Beer < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :brewery

  def average_rating
    reviews.average(:rating)
  end
end
