class BreweryBaseSerializer < ActiveModel::Serializer
  self.root = :brewery
  attributes :id, :name
end