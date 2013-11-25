class Section < ActiveRecord::Base
  attr_accessible :name
  has_many :subsections
  validates :name, presence: true
end
