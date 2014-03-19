class ActivitiesController < ApplicationController
  skip_before_action :require_authentication, only: [:index, :show]
  before_action :set_activity, only: [:show]

  # GET /events
  def index
    @activities = Activity.all
    respond_with @activities
  end

  # GET /show/1
  def show
    respond_with @activity
  end

  private
  def set_activity
    @activity = Activity.find(params[:id])
  end
end
