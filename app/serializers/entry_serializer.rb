class EntrySerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :about, :user_id, :user_name

  def user_name
    object.user.username
  end
end
