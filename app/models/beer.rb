class Beer < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :name
  validates_presence_of :brewery
end
