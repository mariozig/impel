class Api::PostsController < ApplicationController
  def index
    @posts = Post.a_page(params[:page])
  end
end
