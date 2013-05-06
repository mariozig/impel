class PostsController < ApplicationController
  respond_to :json

  def index
    @posts = Post.a_page(params[:page])
  end
end
