class BrewerySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :beers, embed: :ids
end
