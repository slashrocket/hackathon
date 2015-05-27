module ApplicationHelper
  def user_avatar(user)
    image_tag(user.image, size: '35x35', class: 'img-circle profile-image')
  end
end
