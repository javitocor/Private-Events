class EventsController < ApplicationController
  def index
    @events_past = Event.past
    @events_upcoming = Event.upcoming
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    @event.save

    if @event
      redirect_to @event
    else
      flash.now[:danger] = 'Event not created'
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def attend
    attend = Attendance.create(attendee_id: params[:attend][:user_id], attended_event_id: params[:attend][:event_id])

    if attend
      flash[:success] = "Success"
      redirect_to current_user
    end
    
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :date)
  end
end
