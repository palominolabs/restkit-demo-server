class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :comment

  has_one :user
  has_one :beer

end
