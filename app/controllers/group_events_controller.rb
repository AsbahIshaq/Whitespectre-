class GroupEventsController < ApplicationController
  def index
    render json: GroupEvent.where(is_deleted: false)
  end

  def create
    group_event = GroupEvent.create(group_event_params)
    render json: group_event
  end

  def update
    group_event = GroupEvent.find(params[:id])
    group_event.update_attributes(group_event_params)
    render json: group_event
  end

  def destroy
    group_event = GroupEvent.find(params[:id])
    group_event.delete_event
  end

  def dates_between_events
    event1 = GroupEvent.find(params[:event1_id])
    event2 = GroupEvent.find(params[:event2_id])

    dates = GroupEvent.calculate_dates_between_events(event1, event2)

    render json: dates
  end

  private 

  def group_event_params
    params.require(:group_event).permit(:name, :description, :location, :start_date, :end_date, :created_by_id, :is_published)
  end

end
