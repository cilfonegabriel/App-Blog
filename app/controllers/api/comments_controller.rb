class Api::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token

    def index
      @post = Post.find(request.params['post_id'])
      render json: @post.comments.all
    end

    def create
      comment_params = params.require(:comment).permit(:author_id, :post_id, :text)
  
      @user = User.find(comment_params[:author_id])
      @post = Post.find(comment_params[:post_id])
      @comment = @post.comments.create(comment_params)
      @comment.post_id = @post.id
      if @comment.save
        render json: { status: 'OK!' }
      else
        render json: { status: 'Ho no!' }
      end
    end
  end