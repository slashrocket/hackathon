class GetTeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :used, :location, :owner_name, :entry_name

  has_many :users

  def owner_name
    object.owner.username
  end
  def entry_name
    object.entry.name
  end

  def users
        arr = []
    object.users.each do |user|
      arr << {id: user.id, username: user.username, owner: object.owner.username == user.username, accepted: user.team_members_accepted}
    end
    arr
  end
end
