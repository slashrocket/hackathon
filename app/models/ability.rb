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
        can [:basic], TeamMember
        can [:update], Team, owner_id: user.id
        can [:read], Setting
        cannot [:destroy], Team
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
