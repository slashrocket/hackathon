class TeamsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource
  
  def index
    @teams = Team.all
  end

  def show
    
  end

  def new
    
  end

  def create
    
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def team_param
    params.require(:team).permit(:name)
  end
end
