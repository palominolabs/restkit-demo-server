class Beer < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :brewery
end
