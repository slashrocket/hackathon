class Team < ActiveRecord::Base
  has_many :team_members
  has_many :users, -> { select("users.*, team_members.accepted AS team_members_accepted") },
                   through: :team_members
  has_one :entry
  has_one :owner, class_name: "User", primary_key:"owner_id", foreign_key: "id"
  
  validates :name, :uniqueness => true
  
    # Convert team name to friendly url format
  def slug
    name.downcase.gsub(' ', '-').parameterize
  end

  # Change default param for team from id to id-team for friendly urls.
  # When finding in DB, Rails auto calls .to_i on param, which tosses
  # name and doesn't cause any problems in locating team.
  def to_param
    "#{id}-#{slug}"
  end
end
