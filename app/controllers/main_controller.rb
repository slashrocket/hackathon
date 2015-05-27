# Controller for Main model.
class MainController < ApplicationController
  def index
    @allentries = Entry.order('id DESC')
  end

  def home
  end
end
