class Currency < ActiveRecord::Base
  include Option

  attr_accessible :name
  has_many :ads
  validates :name, presence: true, length: {maximum: 20}
  before_destroy :before_destroy

end
