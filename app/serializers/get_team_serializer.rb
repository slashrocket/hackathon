class GetTeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :used, :location, :owner_name, :entry_name

  has_many :users

  def owner_name
    if object.owner
      object.owner.username
    end
  end
  def entry_name
    if object.entry
      object.entry.name
    end
  end

  def users
    arr = []
    if object.users
      object.users.each do |user|
        arr << {id: user.id, username: user.username, owner: object.owner.username == user.username, accepted: user.team_members_accepted}
      end
    end
    arr
  end
end
