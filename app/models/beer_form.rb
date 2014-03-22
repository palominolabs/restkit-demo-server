class BeerForm
  include ActiveModel::Model
  attr_accessor :name, :brewery_id, :inventory, :thumbnail

  validates_presence_of :name
  validates_presence_of :brewery_id
  validates_presence_of :inventory
  validates_numericality_of :inventory, only_integer: true, greater_than_or_equal_to: 0
end