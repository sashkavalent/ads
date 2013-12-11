class Subsection < ActiveRecord::Base
  include Option

  attr_accessible :name, :section_id
  has_many :ads
  belongs_to :section
  validates :name, presence: true,
    format: { with: GlobalConstants::Content_regexp}, length: {maximum: 20}
  before_destroy :before_destroy

end
