class SessionsController < ApplicationController
	skip_before_filter :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:username], params[:password])
      redirect_to projects_path, :flash => { :success => "Login successful!" }
    else
      flash.now[:alert] = "Login failed"
      redirect_to projects_path, :flash => { :warning => "Login failed!" }
    end
  end

  def destroy
    logout
    redirect_to projects_path, notice: 'Logged out!'
  end
end
