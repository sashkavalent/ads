class User < ActiveRecord::Base
  extend Enumerize

  has_many :ads, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  enumerize :role, in: [:guest, :user, :admin], default: :guest

  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :url
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :as => :admin

  default_scope order: 'users.created_at DESC'

  after_create :user_role

  def self.find_for_facebook_oauth access_token

    if user = User.where(:url => access_token.info.urls.Facebook).first
      user
    else
      friendly_token = Devise.friendly_token[0,20]
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Facebook,
        :email => access_token.extra.raw_info.email,
        :password => friendly_token, :password_confirmation => friendly_token)
    end

  end

  def self.find_for_vkontakte_oauth access_token
    if user = User.where(:url => access_token.info.urls.Vkontakte).first
      user
    else
      friendly_token = Devise.friendly_token[0,20]
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Vkontakte,
        :email => access_token.extra.raw_info.screen_name+'@vk.com',
        :password => friendly_token, :password_confirmation => friendly_token)
    end

  end

  private

    def user_role
      self.role = 'user' if self.role == 'guest'
      self.save
    end

end
