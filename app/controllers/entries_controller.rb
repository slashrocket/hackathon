# Controller for Entry model
class EntriesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource
  def index
    @entries = Entry.order('id DESC')
    respond_to do |format|
      format.html
      format.json { render json: @entries}
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
    @entry = current_user.create_entry(entry_params)
    respond_to do |format|
      if @entry.save
        DiscourseAPI.new(current_user.username, 'Hackathon Participant','Code Launch 2015').assign_badge
        format.html { redirect_to @entry, notice: 'Your entry was submitted.' }
        format.json { render json: @entry }
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
    params.require(:entry).permit(:name, :url, :about)
  end

  def default_serializer_options
    {root: false}
  end

end
