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
    @team = Team.new
  end

  def create
    @team = Team.new(team_param)
    @team.owner_id = current_user.id
    @user = User.find_by_id(current_user.id)
    if @team.save
      @teammember = TeamMember.new
      @teammember.user_id = @user.id
      @teammember.team_id = @team.id
      @teammember.accepted = true
      @teammember.owner = true
      @teammember.save!
      @user.team_id = @team.id
      @user.save!
      flash[:notice] = "#{@team.name} Created!"
      return redirect_to user_team_path(@team.id)
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

  def team_param
    params.require(:team).permit(:name, :user_id, :description, :used, :location)
  end
end
