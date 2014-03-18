class Activity < ActiveRecord::Base
  validates_presence_of :type
  validates_inclusion_of :type, in: ['BeerOpenedActivity', 'BeerAddedActivity', 'BeerReviewedActivity']
end
