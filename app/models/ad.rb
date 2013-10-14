class Ad < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  validates :user_id, presence: true, length: {maximum: 140}
  default_scope order: 'ads.created_at DESC'
  state_machine :state, :initial => :drafting do
    event :post do
      transition :drafting => :posting
    end
    event :reject do
      transition :posting => :rejected
    end
    event :approve do
      transition :posting => :approved
    end
    event :publish do
      transition :approved => :published
    end
    event :archive do
      transition :published => :archived
    end
    event :draft do
      transition :rejected => :drafting
    end
  end
end
