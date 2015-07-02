# Controller for Entry model
class EntriesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource
  def index
    @entries = Entry.order('id DESC')
    respond_to do |format|
      format.html
      format.json { render json: @entries, each_serializer: GetEntrySerializer  }
    end
  end

  def new
    @entry = Entry.new
  end

  def total
    @total = Entry.count
    respond_to do |format|
      format.json { render json: {value: @total} }
    end
  end

  def create
    unless current_user.team.owner == current_user
      flash[:alert] = "Only the team owner can submit the entry."
      return redirect_to user_team_path(current_user.team)
    end
    if current_user.team.entry
      flash[:alert] = "Your team has already submitted an entry."
      return redirect_to user_team_path(current_user.team)
    end
    @entry = current_user.team.create_entry(entry_params)
    respond_to do |format|
      if @entry.save
        DiscourseWorker.perform_async(current_user.team.id, 'Hackathon Participant', 'Code Launch 2015')
        format.html { redirect_to @entry, notice: 'Your entry was submitted.' }
        format.json { render json: @entry, serializer: GetEntrySerializer }
      else
        format.html { render :new }
        format.json { render json: {success: false, info: "User wasn't saved"} }
      end
    end
  end

  def show
    @entry = Entry.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @entry }
    end
  end

  def edit
  end

  def destroy
    @entry = Entry.find(params[:id])
    if current_user.role == 'admin'
      Entry.destroy(params[:id])
      respond_to do |format|
        format.html { redirect_to :index}
        format.json { render json: {success: true}}
      end
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:name, :url, :about, :source_code_url)
  end

  def default_serializer_options
    {root: false}
  end

end
