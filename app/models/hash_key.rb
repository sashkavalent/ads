class HashKey < ActiveRecord::Base

  require 'securerandom'

  attr_accessible :value
  before_validation :set_value
  validates :value, presence: true

  private
  def set_value
    self.value = SecureRandom.base64[1..8]
  end

end
