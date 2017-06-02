class UsersController < ApplicationController
  before_action :signed_in_user, except: [:new, :create]
  before_action :correct_user, except: [:new, :create]
  
  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        sign_in @user
        format.html {redirect_to @user , success: 'User was successfully created.'}
      else
        format.html{ render :new, warning: 'Fields can\'t be blank.'}
      end
    end
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])    
  end


  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html {redirect_to @user , success: 'User was successfully updated.'}
      else
        format.html{ render :edit, warning: 'Fields can\'t be blank.'}
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
