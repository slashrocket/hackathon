# Controller for Entry model
class EntriesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id
    respond_to do |format|
      if @entry.save
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

  def index
  end

  def edit
  end

  def delete
  end

  private

  def entry_params
    params.require(:entry).permit(:name, :url, :about, :user_id)
  end
end
