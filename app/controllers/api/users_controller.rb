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

    private

    def default_serializer_options
      {root: false}
    end

  end
end