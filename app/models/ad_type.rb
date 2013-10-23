class AdType < ActiveRecord::Base
  attr_accessible :name

  has_many :ads

  validates :name, presence: true, format: { with: GlobalConstants::Content_regexp},
              length: {maximum: 20}
end
