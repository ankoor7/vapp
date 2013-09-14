class HomeController < ApplicationController
  # load_and_authorize_resource

  def index
    @user = User.new
    # @search_events = @q.result(:distinct => true)
    @groups = Group.page(params[:groups_page]).per(2)
    if current_user && current_user.attending_events?
      @events = Event.available_events(current_user).by_date.page(params[:events_page]).per(6)
      @user_events = current_user.events.by_date.page(params[:user_events_page]).per(4)
    else
      @events = Event.by_date.page(params[:events_page]).per(6)
    end
  end

  def landing
  end

  def search
    @search_events = @q.result(distinct: true).page(params[:events_page]).per(6)
    @causes = Event.tag_counts_on(:causes)
  end

  def cause_cloud
    @causes = Event.tag_counts_on(:causes)
    respond_to do |format|
        format.json { render json: @causes, location: @causes }
    end
  end

end
