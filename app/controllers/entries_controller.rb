# Controller for Entry model
class EntriesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @entries = Entry.order('id DESC')
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.create_entry(entry_params)
    respond_to do |format|
      if @entry.save
        DiscourseAPI.new(current_user.username,"Hackathon Participant").assign_badge
        format.html { redirect_to @entry, notice: 'Your entry was submitted.' }
        # format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        # format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def edit
  end

  def delete
  end

  private

  def entry_params
    params.require(:entry).permit(:name, :url, :about)
  end
end
