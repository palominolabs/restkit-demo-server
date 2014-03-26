class BeerOpenedActivity < Activity
  belongs_to :beer
  belongs_to :user

  validates_presence_of :beer
  validates_presence_of :user
end