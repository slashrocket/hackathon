# Controller for Main model.
class MainController < ApplicationController
  before_filter :authenticate_user!, except: [:home, :rules]

  def home
  end
  
  def rules
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
