class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :reviewed_beers, through: :reviews, class_name: 'Beer', source: :beer

  validates_presence_of :name
  validates_presence_of :email
  validates_format_of :email, with: /@palominolabs/, message: 'must be a Palomino Labs address'
  validates_uniqueness_of :email
  validates_presence_of :password, on: :create
end
