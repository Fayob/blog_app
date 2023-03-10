class PostsController < ApplicationController
  #   user role
  load_and_authorize_resource

  #   get all user post
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
  end

  def all_posts
    @user = params[:user_id]
    @posts = Post.all
  end

  def show
    @post = Post.includes(:author).find(params[:id])
  end

  def new
    @post = Post.new
    @author = User.find(params[:user_id])
  end

  def create_post
    @author = User.find(params[:user_id])
    @post = Post.new(author: @author, title: param['title'], text: param['text'])
    if @post.save
      flash[:notice] = 'Post was created successfully'
      redirect_to "/users/#{@author.id}/posts"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @post = Post.where(author: @user, id: params[:id])
    if @post.update(title: param['title'], text: param['text'])
      flash[:notice] = 'Post was updated Successfully'
      redirect_to "/users/#{@user.id}/posts"
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.where(author: @user, id: params[:id])
    @post.destroy(@post.ids)
    redirect_to "/users/#{@user.id}/posts"
  end

  private

  def param
    params.require(:post).permit(:title, :text)
  end
end
