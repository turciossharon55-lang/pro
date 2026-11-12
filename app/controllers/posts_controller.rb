class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(permit_post)
    if @post.save
      flash[:success] = "Success!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "The post is destroy!"
    end
    redirect_to posts_path
  end

  def edit
  end

  def update
    if @post.update(permit_post)
      flash[:success] = "Post updated!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      redirect_to edit_post_path(@post)
    end
  end

  private

  def require_owner
    @post = Post.find(params[:id])
    unless @post.user == current_user
      flash[:error] = "Solo el dueño del post puede hacer esto"
      redirect_to posts_path
    end
  end

  def permit_post
    params.require(:post).permit(:image, :description)
  end
end
