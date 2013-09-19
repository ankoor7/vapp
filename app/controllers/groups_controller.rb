class GroupsController < ApplicationController
  load_and_authorize_resource
  include AutoHtml

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @events = Event.where(group_id: params[:id]).by_date.page(params[:events_page]).per(4)
    @groupmap = Group.find(params[:id]).to_gmaps4rails
  end

  def new
    @group = Group.new
  end

  def edit
    if params[:search]
      query = "'#{params[:search]}'"
      @search_leaders = User.where("firstname ilike #{query} OR lastname ilike #{query} OR email ilike #{query}")
    end

    @group = Group.includes(:leaders).find(params[:id])
  end

  def create
    @group = Group.new(params[:group])
    @group.cause_list = params[:group][:cause_list]
    @group.cause_search_hack =params[:group][:cause_list]
    @group.leaders << current_user
    respond_to do |format|
      if @group.save
        format.html { redirect_to dashboard_path, notice: 'Your group is ready for events.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find(params[:id])
    @group.cause_list = params[:group][:cause_list]
    @group.cause_search_hack =params[:group][:cause_list]
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to dashboard_path, notice: 'Your group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

end
