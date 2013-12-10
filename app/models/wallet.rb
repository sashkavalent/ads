class Wallet < ActiveRecord::Base
  attr_accessible :balance, :user_id
  belongs_to :user
  validates :balance, :user_id, presence: true
  has_many :payments
end
