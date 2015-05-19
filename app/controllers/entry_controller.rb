class EntryController < ApplicationController
    before_action :authenticate_user!, unless: [:show, :index]
    
    def new 
    end

    def show 
    end

    def index 
    end

    def delete 
    end
end
