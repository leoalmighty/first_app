class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy] # before_filter is just a method
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    # raise params[:user].inspect
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # same as user_path(@user.id)
    else
      @title = "Sign up"
      render 'new'
   end
  end
  
  def edit
    # raise request.inspect
    # @user = User.find(params[:id]) already in before_filter for correct_user
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile updated." }
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
    redirect_to users_path, :flash => { :success => "User destroyed."}
  end
  
  private
  
  def authenticate
    # flash[:notice] = "Please sign in to access this page"
    # redirect_to signin_path, :notice => "Please sign in to access this page" unless signed_in?
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    @user = User.find(params[:id])
    redirect_to(root_path) if !current_user.admin? || current_user?(@user)
  end

end