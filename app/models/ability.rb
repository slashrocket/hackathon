class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, to: :basic

    if user.role == 'admin'
        can :manage, :all
    else
        can [:read], Entry
        can [:create], Entry
        can [:update], Entry, user: { id: user.id }
        can [:basic], User, id: user.id
        can [:read], Team
        can [:create], Team
        can [:update], Team, owner_id: user.id
        cannot [:destroy], Team
        can [:read], Setting
        cannot [:total], User
        cannot [:total], Entry
        cannot [:index], User
        cannot [:update], Setting
        cannot [:firebase_url], Setting
    end
    if !user
      can [:read], Setting
      cannot [:update], Setting
    end
  end
end
