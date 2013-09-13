class UsersController < ApplicationController
  load_and_authorize_resource

  def dashboard
    @user_events = current_user.events.by_date.page(params[:user_events_page]).per(5)
    @groups = current_user.led_groups.includes(:events).page(params[:groups_page]).per(3)
  end

  def search
    if params[:search]
      query = "'#{params[:search]}'"
      @users = User.where("firstname ilike #{query} OR lastname ilike #{query} OR email ilike #{query}")
    else
      @users = User.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @users }
    end
  end


  def show
    @user = User.includes(:led_groups).find(params[:id])
  end

  def account
    @user = User.includes(:led_groups).find(current_user.id)
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
  end
end

