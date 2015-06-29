class TeamsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource

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
    @team = Team.create(name: team_param[:name], owner_id: current_user.id)
    @team.save
    if @team.save
      format.html { redirect_to @team, notice: 'Your team has been created.' }
      format.json { render json: @team }
    else
      format.html { render :new }
      format.json { render json: {success: false, info: "User wasn't saved"} }
    end
  end

  def join
    @team = Team.find(params[:id])
    @team.users << current_user
    @team.save!
    format.html { redirect_to @team, notice: 'Your join request has been submitted' }
    format.json { render json: @team }
  end

  def aprove
    if @team.owner == current_user
    else
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
    params.require(:team).permit(:name)
  end
end
