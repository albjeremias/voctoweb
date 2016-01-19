class Public::EventsController < ActionController::Base
  include ApiErrorResponses
  include ThrottleConnections
  respond_to :json

  # GET /public/events/1.json
  def show
    @event = Event.find(params[:id])
  end
end
