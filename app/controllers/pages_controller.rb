class PagesController < ApplicationController
  
  def index
    return home
  end
  
  def home
    @title = "Home"
    @micropost = Micropost.new if signed_in?
  end
  
  def help
    @title = "Help"
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end

end