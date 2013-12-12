class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new()
    if user.role.guest?
      can :read, Ad
    end

    if user.role.user?

      can :read, Ad
      can :show, User, :role => 'user'

      can :destroy, user.ads
      can :update, Ad, :state => 'drafting', :user_id => user.id
      can :change_state, Ad,
        :state => ['drafting', 'rejected', 'archived'], :user_id => user.id
      can :create, Ad

      can :manage, user.comments
      can :create, Comment
      can :destroy, user.announcements
      can :read, Announcement
      can :clear, Announcement

    end

    if user.role.admin?
      can :read, :all
      can :destroy, :all
      can :make_admin, User
      can :change_state, Ad, :state => 'posting'
      can :manage, AdType
      can :manage, Place
      can :manage, Section
      can :manage, Subsection
      can :manage, Currency
    end
  end
end
