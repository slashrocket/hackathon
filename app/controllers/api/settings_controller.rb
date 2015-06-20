module Api
  class SettingsController < ApplicationController
    before_filter :authenticate_user!
    respond_to :json
    load_and_authorize_resource

    def index
      @settings = Setting.unscoped
      respond_to do |format| 
        format.json { render json: @settings } 
      end
    end

    def firebase_url
      @setting = Setting.firebase_url
      respond_to do |format|
        format.json { render json: {value: @setting} }
      end
    end

    def update
      @setting = Setting.unscoped.find(params[:id])
      @setting.update_attributes(setting_params)
      respond_to do |format| 
        format.json { render json: @setting } 
      end
    end

    private

    def default_serializer_options
      {root: false}
    end

    def setting_params
      params.require(:setting).permit(:var, :value)
    end
  end
end