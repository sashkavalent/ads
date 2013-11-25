class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new()
    if user.role.guest?
      can :read, Ad
    end

    if user.role.user?

      can :read, Ad
      can :show, User

      can :destroy, user.ads
      can :update, Ad, :state => 'drafting', :user_id => user.id
      can :change_state, Ad,
        :state => ['drafting', 'rejected', 'archived'], :user_id => user.id
      can :create, Ad

      can :manage, user.comments
      can :create, Comment

    end

    if user.role.admin?
      can :read, :all
      can :destroy, :all
      can :update, User
      can :change_state, Ad, :state => 'posting'
      can :manage, AdType
      can :manage, Place
      can :manage, Section
      can :manage, Subsection
    end
  end
end
