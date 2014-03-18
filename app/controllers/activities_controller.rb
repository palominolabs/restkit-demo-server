class ActivitiesController < ApplicationController
  skip_before_action :require_authentication, only: [:index, :show]
  before_action :set_activity, only: [:show]

  # GET /events
  def index
    @activities = Activity.all
  end

  # GET /show/1
  def show
  end

  private
  def set_activity
    @activity = Activity.find(params[:id])
  end
end
