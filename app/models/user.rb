class User < ActiveRecord::Base
  ROLES = %w[guest user admin]

  has_many :ads, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :role

  default_scope order: 'users.created_at DESC'

  after_create :default_role

  def role?(base_role)
  	ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def admin?
    role? :admin
  end

  private

    def default_role
      self.role ||= 'user'
      self.save
    end
end
