class Ad < ActiveRecord::Base
  attr_accessible :content, :photos_attributes, :ad_type_id

  belongs_to :user
  belongs_to :ad_type
  has_many :photos, :dependent => :destroy

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 200}, format: { with: GlobalConstants::Content_regexp }
  validates :ad_type_id, presence: true

  accepts_nested_attributes_for :photos, :allow_destroy => true

  state_machine :state, :initial => :drafting do

    after_transition :approved => :published do |ad, transition|
      ad.published_at = Time.now
      ad.save
    end

    after_transition :published => :archived do |ad, transition|
      ad.published_at = nil
      ad.save
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
  end

  def self.search(params)

    @ads = Ad.includes(:user).includes(:ad_type).includes(:photos).where(state: 'published')

    if params[:search]
      @ads = @ads.where('lower(content) LIKE ?', "%#{params[:search].downcase}%")
    end

    if params[:created_id]

      if params[:ad_type_id] != '0'
        @ads = @ads.where(ad_type_id: params[:ad_type_id])
      end

      if params[:created_id] == '1'
        @ads = @ads.order('created_at DESC')
      elsif params[:created_id] == '2'
        @ads = @ads.order('created_at ASC')
      end

    else
      @ads = @ads.order('created_at DESC')
    end

    @ads
  end

end
