class BeerReviewedActivity < Activity
  belongs_to :review

  validates_presence_of :review
end