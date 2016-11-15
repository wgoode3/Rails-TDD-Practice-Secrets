class UsersController < ApplicationController
  def register
  end

  def create
  	user = User.create(user_params)
  	if user.valid?
  	  session[:user_id] = user.id
  	  redirect_to "/users/#{user.id}"
  	else
  	  flash[:errors] = user.errors.full_messages
  	  redirect_to '/users/new'
  	end
  end

  def login
  end

  def checklogin
  	user = User.find_by_email(params[:user][:email])
  	if user == nil
  	  flash[:errors] = ["Email not found!"]
  	  redirect_to '/sessions/new'
  	else
	  if user && user.authenticate(params[:user][:password])
  	    session[:user_id] = user.id
  	    redirect_to "/users/#{user.id}"
  	  else
  	    flash[:errors] = ["Password does not match!"]
  	    redirect_to '/sessions/new'
  	  end
  	end
  end

  def logout
  	reset_session
  	redirect_to "/sessions/new"
  end

  def show
  	@user = User.find(params[:id])
  	@secrets = Secret.where(user_id: params[:id])
  	@likes = Like.all
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	User.update(params[:id], name: params[:name], email: params[:email])
  	redirect_to "/users/#{params[:id]}/edit"
  end

  def delete
  	User.find(params[:id]).destroy
  	reset_session
  	redirect_to "/sessions/new"
  end

  def secrets
  	@secrets = Secret.all
  	@likes = Like.all
  end

  def newsecret
  	Secret.create(content: params[:content], user_id: params[:id])
  	redirect_to "/users/#{params[:id]}"
  end

  def destroysecret
  	Secret.find(params[:id]).destroy
  	redirect_to "/users/#{session[:user_id]}"
  end

  def likes
    if session[:user_id] == nil
      redirect_to "/sessions/new"
    else
      check = Like.where(user_id: session[:user_id]).where(secret_id: params[:id])
  	  if not check.exists?
  		  Like.create(user_id: session[:user_id], secret_id: params[:id])
  	  end
      redirect_to "/secrets"
  	end
  end

  def unlikes
  	Like.where(user_id: session[:user_id]).where(secret_id: params[:id])[0].destroy
  	redirect_to "/secrets"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
