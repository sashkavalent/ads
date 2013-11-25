class Place < ActiveRecord::Base
  has_many :ads
  attr_accessible :name
  validates :name, presence: true
end
