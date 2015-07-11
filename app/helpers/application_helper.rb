# Overall helper
module ApplicationHelper
  def user_avatar(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"

    image_tag(gravatar_url, size: '35x35', class: 'img-circle profile-image')
  end

  def admin_button
    link_to 'Admin Panel', admin_url, data: { no_turbolink: true }
  end
  # for nice notifications with toastr
  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      puts type

      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
