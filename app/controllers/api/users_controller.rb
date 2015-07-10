module Api
  class UsersController < ApplicationController
    before_filter :authenticate_user!
    respond_to :json
    load_and_authorize_resource
    
    def index
      @users = User.includes(:team).all
      respond_to do |format| 
        format.json { render json: @users, each_serializer: GetUserSerializer } 
      end
    end

    def total
      @total = User.count
      respond_to do |format|
        format.json { render json: {value: @total } }
      end
    end

    def update
      if current_user.role == 'admin'
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
          respond_to do |format|
            format.json { render json: @user }
          end
        end
      end
    end

    def destroy
      if current_user.role == 'admin'
        respond_with User.destroy(params[:id])
      end
    end

    private

    def default_serializer_options
      {root: false}
    end

    def user_params
      params.require(:user).permit(:username, :email, :role)
    end

  end
end