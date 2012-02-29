class PromotionsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy
  
  def create
    @promotion = current_user.promotions.build(params[:promotion])
    if @promotion.save
      redirect_to root_path, :flash => { :success => "Promotion created!" }
    else
      @feed_items = [ ]
      render 'pages/home'
    end
  end

  def destroy
    @promotion.destroy
    redirect_to root_path, :flash => { :success => "Promotion deleted!" }
  end
  
  private
  
    def authorized_user
      @promotion = current_user.promotions.find_by_id(params[:id])
      redirect_to root_path if @promotion.nil?
    end
end