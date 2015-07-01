class GetEntrySerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :about, :team_name

  def team_name
    object.team.name
  end
end
