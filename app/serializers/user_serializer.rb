class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :image, :role, :uid
end
