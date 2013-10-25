class User < ActiveRecord::Base
  extend Enumerize

  has_many :ads, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerize :role, in: [:guest, :user, :admin], default: :guest

  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :as => :admin

  default_scope order: 'users.created_at DESC'

  after_create :user_role

  private

    def user_role
      self.role = 'user' if self.role == 'guest'
      self.save
    end

end
