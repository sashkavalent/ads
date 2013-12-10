class Payment < ActiveRecord::Base
  @@coin_number = 10
  @@day_number = 3
  @@coin_for_days_number = 5

  attr_accessible :amount, :wallet_id
  validates :amount, :wallet_id, presence: true
  belongs_to :wallet

  def self.coin_number
    @@coin_number
  end

  def self.day_number
    @@day_number
  end

  def self.coin_for_days_number
    @@coin_for_days_number
  end
end
