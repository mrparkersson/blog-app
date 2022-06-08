class PostsController < ActionController::Base
  def index
    @user = User.find(params[:user_id])
    @posts = Post.all.where(user_id: @user.id)
  end

  def show
    @post = Post.find(params[:id])
  end
end
