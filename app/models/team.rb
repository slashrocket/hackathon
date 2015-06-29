class Team < ActiveRecord::Base
  has_many :team_members
  has_many :users, through: :team_members
  has_one :entry, as: :ownable
end
