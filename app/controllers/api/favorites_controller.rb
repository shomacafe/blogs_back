class Api::FavoritesController < ApplicationController
  before_action :authenticate_api_user!, only: [:index, :create, :destroy]

  def create
    post = Post.find(params[:post_id])

    if current_api_user.id == post.user.id
      render json: { error: '自分の投稿にはお気に入り登録できません' }, status: :unprocessable_entity
      return
    end

    @favorite = current_api_user.favorites.build(post_id: params[:post_id])

    if @favorite.save
      render json: @favorite, status: :created
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = current_api_user.favorites.find_by(post_id: params[:id])

    if @favorite
      @favorite.destroy
      head :no_content
    else
      render json: { error: 'お気に入りが見つかりません' }, status: :not_found
    end
  end

  def favorite_posts
    favorite_post_ids = current_api_user.favorites.pluck(:post_id)

    @favorite_posts = Post.where(id: favorite_post_ids)

    render json: @favorite_posts, status: :ok
  end

  def favorite_status
    user_id = params[:user_id]
    post = Post.includes(:favorites).find(params[:id])
    is_favorite = Favorite.exists?(user_id, post.id)
    render json: { is_favorite: is_favorite }
  end
end
