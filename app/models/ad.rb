class Ad < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  validates :user_id, presence: true, length: {maximum: 140}
  default_scope order: 'ads.created_at DESC'
  state_machine :state, :initial => :pending do
    event :publish do
      transition all => :published
    end
  end
end
