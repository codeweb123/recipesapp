class UsersController < ApplicationController
before_action :instance_of_user, only: [:show, :edit, :update, :destroy]
before_action :require_same_user, only: [:edit, :update, :destroy]   
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome #{@user.username} to RecipesApp!"
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    def show 
        @user_recipes = @user.recipes.paginate(page: params[:page], per_page: 5)
    end

    def edit   
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Your account was updated!"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def destroy
        @user.destroy
        flash[:danger] = "User has been deleted"
        redirect_to users_path
    end

private
    def instance_of_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def require_same_user
        if current_user != @user
            flash[:danger] = "You can only edit or delete your own account"
            redirect_to users_path
        end
    end
end