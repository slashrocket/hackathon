class GetUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :image, :role, :uid, :team_name

  def team_name
    if object.team
      object.team.name
    end
  end
end