class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, to: :basic

    if user.role == 'admin'
        can :manage, :all
    else
        can [:read], Entry
        can [:create], Entry, user_id: user.id
        can [:update], Entry, user_id: user.id
        can [:basic], User, id: user.id
        can [:read], Setting
        cannot [:index], User
        cannot [:update], Setting

    end
    if !user
      can [:read], Setting
      cannot [:update], Setting
    end
  end
end
