class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :inventory, :average_rating, :reviews_count
  has_one :brewery, serializer: BreweryBaseSerializer
end
