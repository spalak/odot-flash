class UserSessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
	  	redirect_to todo_lists_path
	  	session[:user_id] = user.id
	  	flash[:success] = "Thanks for logging in"
	else
		flash[:error] = "There was a problem logging in.  Please check your email and password"
		render :action => 'new'
	end
  end
end
