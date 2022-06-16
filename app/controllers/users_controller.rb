class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end
end
