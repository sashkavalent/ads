class User < ActiveRecord::Base
  extend Enumerize

  has_many :ads, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :announcements, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  enumerize :role, in: [:guest, :user, :admin], default: :guest

  attr_accessible :first_name, :last_name, :email, :password,
    :password_confirmation, :remember_me, :provider, :url
  attr_accessible :first_name, :last_name, :email, :password,
    :password_confirmation, :remember_me, :role, :as => :admin

  validates :first_name, :last_name, :email, presence: true

  default_scope order: 'users.created_at DESC'

  after_create :user_role

  def name
    first_name + ' ' + last_name
  end

  def self.find_for_oauth access_token

    info = access_token.info

    if access_token.provider == 'vkontakte'
      email = access_token.extra.raw_info.screen_name + '@vk.com'
    else
      email = info.email
    end

    if user = User.where(email: email).first
      user
    else
      friendly_token = Devise.friendly_token[0,20]
      User.create!(first_name: info.first_name, last_name: info.last_name,
        email: email, :provider => access_token.provider,
        :url => access_token.info.urls[access_token.provider.capitalize],
        password: friendly_token, password_confirmation: friendly_token)
    end

  end

  private

    def user_role
      self.role = 'user' if self.role == 'guest'
      self.save
    end

end
