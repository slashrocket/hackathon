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
        can [:update], Entry, team: { user_id: user.id }
        can [:uodate], Entry, user: { id: user.id }
        can [:basic], User, id: user.id
        can [:read], Team
        can [:update], Team, id: user.team_id
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
