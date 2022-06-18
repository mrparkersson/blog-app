class CommentsController < ApplicationController
  skip_before_action :authenticate_request
  before_action :authenticate_request, only: [:add_comment]
  protect_from_forgery with: :null_session, only: [:add_comment]

  def create
    @post = Post.find(params[:post_id])
    @user = @post.author
    new_comment = current_user.comments.new(
      text: comment_params,
      author_id: current_user.id,
      post_id: @post.id
    )
    new_comment.update_comments_counter
    if new_comment.save
      redirect_to user_post_path(@user, @post), notice: 'Success!'
    else
      render :new, alert: 'Error occured!'
    end
  end

  def comments
    post = Post.find(params[:id])

    respond_to do |format|
      format.json { render json: post.comments }
    end
  end

  def add_comment
    comment = Comment.new(author: @curr_user, post_id: params[:post_id], text: params[:text])

    respond_to do |format|
      if comment.save
        format.json { render json: comment }
      else
        format.json { render json: { success: false, message: comment.errors.full_messages } }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(@comment.post_id)
    @post.comments_counter -= 1
    @comment.destroy!
    @post.save
    flash[:success] = 'You have deleted this post!'
    redirect_to user_path(current_user.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end
