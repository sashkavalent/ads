class Section < ActiveRecord::Base
  include Option

  attr_accessible :name
  has_many :subsections
  validates :name, presence: true,
    format: { with: GlobalConstants::Content_regexp}, length: {maximum: 20}
  before_destroy :before_destroy

  def before_destroy
    if !self.subsections.blank?
      errors.add(:subsections, 'must be blank')
      false
    end
  end

end
