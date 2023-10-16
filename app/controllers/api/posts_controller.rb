class Api::PostsController < ApplicationController
  before_action :authenticate_api_user!, only: [:create, :update, :destroy, :my_posts]
  before_action :find_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.includes(:user).all
    render json: @posts, include: [:user]
  end

  def create
    @post = current_api_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @post, serializer: PostSerializer, include: [:user, comments: [:user]]
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  def index_for_blogs
    @users = User.joins(:posts).distinct
    render json: @users, include: [:posts]
  end

  def index_by_user
    user_id = params[:user_id]

    @posts = Post.where(user_id: user_id)
    render json: @posts, each_serializer: PostSerializer
  end

  def my_posts
    @posts = current_api_user.posts
    render json: @posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
