class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, :only => :create

    def new
    
    end

    def omnicreate
        if auth_hash = request.env['omniauth.auth'] #they logged in via OAuth
            user = User.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || User.create_with_omniauth(auth_hash)     
            session[:user_id] = user.id     
            redirect_to user, :notice => "You are logged in through Github Omniauth!!"
        else
            user = User.find_by(params[:session][:email].downcase)
            if user && user.authenticate(params[:session][:password])
                session[:user_id] = user.id
                flash[:success] = "You have logged in"
                redirect_to user
            else
                flash.now[:danger] = "There is something wrong"
                render 'new'
            end
        end
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
            if user && user.authenticate(params[:session][:password])
                session[:user_id] = user.id
                flash[:success] = "You have logged in"
                redirect_to user
            else
                flash.now[:danger] = "There is something wrong"
                render 'new'
            end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "You have logged out"
        redirect_to root_path
    end

    private
    def auth_hash
        request.env["omniauth.auth"]
    end
end   
