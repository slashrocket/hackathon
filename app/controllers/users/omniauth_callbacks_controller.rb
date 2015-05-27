# Controller for logging into Slack via Omniauth and Devise
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def slack
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Slack') if is_navigational_format?
    else
      session['devise.slack_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
