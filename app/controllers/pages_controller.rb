class PagesController < ApplicationController

  def home
    @title = "Home"
    if signed_in?
      @promotion = Promotion.new
      @feed_items = current_user.feed.paginate(:per_page => 25, :page => params[:page])
            
      respond_to do |format|
        format.js
        format.html
      end
    end 
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
  def help
    @title = "Help"
  end
end