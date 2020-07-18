class CommentsController < ApplicationController
    before_action :require_user

    def index
      if logged_in?
        @recipe = Recipe.find_by_id(params[:recipe_id])
        @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
      else
        flash[:message] = "You have to be logged in!"
        redirect_to login_path
      end
    end

    def new
      if logged_in?
        @recipe = Recipe.find_by_id(params[:recipe_id])
        @comment = @recipe.comments.build
      else
        flash[:message] = "You have to be logged in!"
        redirect_to login_path
      end
    end
    
    def create
      @recipe = Recipe.find(params[:recipe_id])
      @comment = @recipe.comments.build(comment_params)
      @comment.user = current_user
      if @comment.save
        flash[:success] = "Comment was created"
        redirect_to recipe_comments_path(@recipe)
      else
        flash[:danger] = "Comment was not created"
        render 'new'
      end
    end
    
    private
    
    def comment_params
      params.require(:comment).permit(:description)
    end
    
  end