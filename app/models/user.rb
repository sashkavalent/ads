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

  def self.find_for_oauth access_token

    if access_token.provider == 'vkontakte'
      user = User.where(:url => access_token.info.urls.Vkontakte).first
      email = access_token.extra.raw_info.screen_name + '@vk.com'
    else
      user = User.where(email: access_token.info['email']).first
      email = access_token.extra.raw_info.email
    end

    if user
      user
    else
      friendly_token = Devise.friendly_token[0,20]
      User.create!(:provider => access_token.provider, :url => access_token
          .info.urls[access_token.provider.capitalize],
        email: email,
        password: friendly_token, password_confirmation: friendly_token)
    end

  end

  private

    def user_role
      self.role = 'user' if self.role == 'guest'
      self.save
    end

end
