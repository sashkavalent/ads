class Subsection < ActiveRecord::Base
  attr_accessible :name, :section_id
  belongs_to :section
  has_many :ads
  validates :name, :section_id, presence: true
end
