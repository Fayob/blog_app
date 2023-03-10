class Api::CommentsController < ApplicationController
  skip_before_action :authenticate_request

  def index
    user = User.includes(:posts).find(params[:user_id])
    post = user.posts.includes(:comments).find(params[:post_id])

    render json: post.comments
  end

  def create
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    comment = Comment.new(author: user, post:, text: param['text'])

    if comment.save
      render json: comment, status: :created
    else
      render json: {
        error: 'Unable to create comment'
      }, status: 401
    end
  end

  private

  def param
    params.require(:comment).permit(:text)
  end
end
