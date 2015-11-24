class SessionsController < ApplicationController
	def new
	end

	def create
	  user = User.find_by_email(params[:session][:email].downcase)
	  if user && user.authenticate(params[:session][:password])
	    log_in user
	    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
	    flash[:success] = 'Welcome back and happy bidding!'
	    redirect_to root_url 
	  else
	    flash.now[:danger] = 'Invalid email or password. Please try again!'
	    render "new"
	  end
	end

	def destroy
	  cookies.delete(:auth_token)
	  log_out if logged_in?
	  flash[:success] = 'Logged out successfully. See you again soon!'
      redirect_to root_url
	end
end