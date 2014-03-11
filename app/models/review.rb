class Review < ActiveRecord::Base
  belongs_to :beer
  validates_presence_of :reviewer
  validates_presence_of :rating
  validates_presence_of :beer
end
