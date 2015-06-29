class Team < ActiveRecord::Base
  has_many :team_members
  has_many :users, -> { select("users.*, team_members.accepted AS team_members_accepted") },
                   through: :team_members
  has_one :entry
end
