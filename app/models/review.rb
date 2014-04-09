class Review < ActiveRecord::Base
  belongs_to :beer, counter_cache: true
  belongs_to :user
  has_many :beer_reviewed_activities, dependent: :destroy

  validates_presence_of :rating
  validates_numericality_of :rating, only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5
  validates_presence_of :beer
  validates_presence_of :user
end
