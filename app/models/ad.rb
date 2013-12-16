class Ad < ActiveRecord::Base

  attr_accessible :content, :photos_attributes, :ad_type_id, :place_id, :subsection_id, :currency_id, :price

  belongs_to :user
  belongs_to :ad_type
  belongs_to :place
  belongs_to :subsection
  belongs_to :currency

  has_many :photos, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :announcements, :dependent => :destroy
  has_and_belongs_to_many :keywords

  validates :user_id, :ad_type_id, :place_id, :subsection_id,
    :currency_id, presence: true
  validates :content, presence: true, length: {maximum: 200}, format: { with: GlobalConstants::Content_regexp }

  accepts_nested_attributes_for :photos, :allow_destroy => true

  default_scope order: 'ads.created_at DESC'

  scope :published, -> { where(state: 'published') }
  scope :posting, -> { where(state: 'posting') }

  @@Per_page_small = 5
  @@Per_page_big = 12
  @@max_price = 2 ** (1.size * 8 - 1)


  def self.max_price
    @@max_price
  end
  def self.per_page_small
    @@Per_page_small
  end
  def self.per_page_big
    @@Per_page_big
  end

  validates_numericality_of :price, greater_than_or_equal_to: 0,
    less_than: max_price, :allow_nil => true,
    :message => "can only be ranged number"

  state_machine :state, :initial => :drafting do

    after_transition :approved => :published do |ad, transition|
      ad.published_at = Time.now
      ad.save
    end

    after_transition :published => :archived do |ad, transition|
      ad.published_at = nil
      ad.save
      new_announcement(ad, transition)
    end

    after_transition :posting => any do |ad, transition|
      new_announcement(ad, transition)
    end

    after_transition any => [:published, :archived] do |ad, transition|
      new_announcement(ad, transition)
    end

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
      transition [:rejected, :archived] => :drafting
    end

    def new_announcement(ad, transition)
      an = ad.user.announcements.build(ad_id: ad.id,
        content: I18n.translate(:was, scope: [:ads]) + transition.to);
      an.save
    end
  end

end
