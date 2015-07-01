class GetUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :image, :role, :uid, :team_name

  def team_name
    object.team.name
  end
end