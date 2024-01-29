class UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user 
      render "show"
    else
      render "show_#{@user.role}"
    end
  end

end
