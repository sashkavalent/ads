class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new()
    if user.role.guest?
      can :read, Ad
    end

    if user.role.user?
      can :read, :all
      can :destroy, user.ads
      can :update, user.ads.where(state: 'drafting')
      can :change_state, user.ads.where(state: 'drafting')
      can :create, Ad
    end

    if user.role.admin?
      can :read, :all
      can :destroy, :all
      can :update, User
      can :change_state, Ad.where(state: 'posting')
      can :manage, AdType
    end
  end
end
