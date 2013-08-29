class EventsController < ApplicationController

  def index
    @events = Events.all
  end

  def show
    @event = Event.find(params[:id])
    @eventmap = Event.find(params[:id]).to_gmaps4rails
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])
    @event.cause_list = params[:event][:cause_list]
    # EDIT TO INCLUDE MULTIGROUP FUNCTIONALITY
    # assign a relevent group, not the first group of the current_user
    @event.group = current_user.led_groups.first
    @event.date=DateTime.new(params[:date][:year].to_i,params[:date][:month].to_i,params[:date][:day].to_i,params[:date][:hour].to_i,params[:date][:minute].to_i,params[:date][:second].to_i)
    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: 'Your event is ready for volunteers.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @event = Event.find(params[:id])
    @event.cause_list = params[:event][:cause_list]
    @event.date=DateTime.new(params[:date][:year].to_i,params[:date][:month].to_i,params[:date][:day].to_i,params[:date][:hour].to_i,params[:date][:minute].to_i,params[:date][:second].to_i)
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Your event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.json { head :no_content }
    end
  end

end
