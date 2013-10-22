class Ad < ActiveRecord::Base
  attr_accessible :content, :photos_attributes, :ad_type_id

  belongs_to :user
  belongs_to :ad_type
  has_many :photos, :dependent => :destroy

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}, format: { with: GlobalConstants::Content_regexp }
  validates :ad_type_id, presence: true

  default_scope order: 'ads.created_at DESC'

  accepts_nested_attributes_for :photos, :allow_destroy => true

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
