class BeerReviewedActivitySerializer < ActiveModel::Serializer
  attributes :id, :type
  has_one :review
end
