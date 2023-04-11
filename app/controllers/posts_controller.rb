class PostsController < ApplicationController
    def index
        @posts = @user.posts
        @user = User.find(params[:user_id])
    end

    def show
        @post = @user.posts.find(params[:id])
        @user = User.find(params[:user_id])
    end
end
