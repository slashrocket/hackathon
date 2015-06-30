# Controller for Main model.
class MainController < ApplicationController
  before_filter :authenticate_user!, except: [:home, :rules]

  def home
    if current_user
      if current_user.team
        redirect_to user_team_url(current_user.team)
      else
        redirect_to welcome_path
      end
    end
  end
  
  def homeregistered
    render :home
  end
  
  def rules
  end
  
  def welcome
  end

  def admin
    authorize!(:admin, :main)
    if user_signed_in? && current_user.role == 'admin'
      render action: 'admin', layout: 'angularapp'
    else
      redirect_to root_path
    end
  end
end
