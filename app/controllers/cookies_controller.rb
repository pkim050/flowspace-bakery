class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookies.present?
      redirect_to @oven, alert: 'A cookie is already in the oven!'
    else
      @cookie = @oven.cookies.build
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    for i in 1..params[:quantity].to_i
      @cookie = @oven.cookies.create!(cookie_params)
      BakingWorkerWorker.perform_in(30.seconds, @cookie.id)
    end
    redirect_to oven_path(@oven)
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings)
  end
end
