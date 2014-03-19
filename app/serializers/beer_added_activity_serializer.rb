class BeerAddedActivitySerializer < ActiveModel::Serializer
  attributes :id, :type

  has_one :beer
  has_one :user
end
