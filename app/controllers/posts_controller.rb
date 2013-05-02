class PostsController < ApplicationController
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(25)
  end
end
