class LikesController < ApplicationController
  skip_before_action :authenticate_request

  def create
    @post = Post.find(params[:post_id])
    @user = @post.author
    new_like = current_user.likes.new(
      author_id: current_user.id,
      post_id: @post.id
    )
    new_like.update_likes_counter
    if new_like.save
      redirect_to "/users/#{@post.user_id}/posts/#{@post.id}", notice: 'Success!'
    else
      redirect_to "/users/#{@post.user_id}/posts/#{@post.id}", alert: 'Error occured!'
    end
  end
end
