class CommentsController < ApplicationController
    def new
        @comments = Comment.new
    end
end
