class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy

  validates_presence_of :name
end
