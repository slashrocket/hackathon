class Users::SessionsController < Devise::SessionsController

  def show_current_user
    if user_signed_in? && current_user.role == 'admin'
      user_data
    else
      failure
    end
  end

  def user_data
    render status: 200,
           json: {
            success: true,
            info: "Current User",
            user: current_user
           }
  end

  def failure
    render status: 401,
           json: {
            success: false,
            info: "Unauthorized"
           }
  end

end