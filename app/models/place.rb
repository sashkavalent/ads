class Place < ActiveRecord::Base
  include Option

  attr_accessible :name
  has_many :ads
  validates :name, presence: true,
    format: { with: GlobalConstants::Content_regexp}, length: {maximum: 20}
  before_destroy :before_destroy

end
