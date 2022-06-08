class PostsController < ActionController::Base
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).order(created_at: :DESC).page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
  end
end
