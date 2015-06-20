# Overall helper
module ApplicationHelper
  def user_avatar(user)
    image_tag(user.image, size: '35x35', class: 'img-circle profile-image')
  end

  def admin_button
    link_to 'Admin Panel', admin_url, data: { no_turbolink: true }
  end
end
