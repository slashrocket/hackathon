class MainController < ApplicationController
  def index
    @allentries = Entry.all
  end
end
