class PagesController < ApplicationController
  
  def index
    return home
  end
  
  def home
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end

end