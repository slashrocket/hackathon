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
    if @team.owner == current_user || current_user.role == 'admin'
      @team = Team.includes(:owner, team_members:[:user]).find(params[:id])
    else
      @team = Team.includes(:owner, team_members:[:user]).where(team_members: {accepted: true}).find(params[:id])
    end
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
    @team = Team.new(team_params.merge(owner_id: current_user.id))
    if @team.save
      @team.users << current_user
      respond_to do |format|
        format.html do
          flash[:notice] = "#{@team.name} Created!"
          redirect_to user_team_path(@team)
        end
        format.json { render json: @team }
      end
    else
      flash[:alert] = "Failed to create team"
      render new
    end
  end

  def join
    @team = Team.find(params[:id])
    @team.users << current_user
    flash[:notice] = "Your request to join #{@team.name} has been submited!"
    redirect_to user_team_path(@team)
  end

  def aprove
    @team = Team.find(params[:id])
    @team_member = @team.team_members.where(user_id: params[:user_id]).take
    @team_member.accept!
    DiscourseUpdateWorker.perform_async(current_user.team.id, 'Hackathon Participant', 'Code Launch 2015') if @team.entry
    flash[:notice] = "The user has been aproved!"
    redirect_to user_team_path(@team)
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def team_params
    params.require(:team).permit(:name, :description, :used, :location, :owner_id)
  end
end
