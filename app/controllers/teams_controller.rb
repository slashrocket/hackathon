class TeamsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource :team
  load_and_authorize_resource :team_member, through: :team

  def index
    @teams = Team.all
    respond_to do |format|
      format.html
      format.json { render json: @teams}
    end
  end

  def show
    @team = Team.includes(:owner, team_members:[:user]).find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @team }
    end
  end

  def new
    if current_user.team
      flash[:alert] = "You are already the member of a team"
      return redirect_to root_path
    end
    @team = Team.new
  end

  def create
    team_params.merge(owner_id: current_user.id)
    @team = Team.new(team_params)
    if @team.save
      @team.users << current_user
      respond_to do |format|
        format.html do
          flash[:notice] = "#{@team.name} Created!"
          redirect_to user_team_path(@team.id)
        end
        format.json { render json: @team }
      end
    else
      flash[:alert] = "Failed to create team"
      render new
    end
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def team_params
    params.require(:team).permit(:name, :description, :used, :location)
  end
end
