class AdType < ActiveRecord::Base
  attr_accessible :name

  has_many :ads

  validates :name, format: { with: GlobalConstants::Content_regexp},
              length: {maximum: 20}
end
