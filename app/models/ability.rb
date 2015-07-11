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
        can [:basic], Team
        can [:update], Team, owner_id: user.id
        can [:basic], TeamMember
        can [:read], Setting
        can [:join], Team
        can [:approve], Team
        cannot [:destroy], Team
        cannot [:total], User
        cannot [:total], Entry
        cannot [:index], User
        cannot [:update], Setting
        cannot [:firebase_url], Setting
    end
    if !user
      can [:read], Team
      cannot [:update], Team
      can [:read], Setting
      cannot [:update], Setting
    end
  end
end
