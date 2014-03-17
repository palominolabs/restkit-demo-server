class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy

  validates_presence_of :name

  def average_rating
    rated_beer_scores = beers.map(&:average_rating).compact
    (rated_beer_scores.sum / rated_beer_scores.length).round(1) if rated_beer_scores.any?
  end
end
