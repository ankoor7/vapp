class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    # Eager Load group with its events
    # @group = Group.includes(:events).where(id: params[:id])
    @group = Group.find(params[:id])
    @events = Event.where(group_id: params[:id])
    @groupmap = Group.find(params[:id]).to_gmaps4rails
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(params[:group])
    @group.leaders << current_user
    respond_to do |format|
      if @group.save
        format.html { redirect_to root_path, notice: 'Your group is ready for events.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find(params[:id])
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Your group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

end