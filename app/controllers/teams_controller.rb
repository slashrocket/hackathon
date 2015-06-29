class TeamsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource except: [:new, :create]

  def index
    @teams = Team.all
    respond_to do |format|
      format.html
      format.json { render json: @teams}
    end
  end

  def show
    @team = Team.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
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
