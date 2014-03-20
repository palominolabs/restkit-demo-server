class ActivitiesController < ApplicationController
  skip_before_action :require_authentication, only: [:index, :show]
  before_action :set_activity, only: [:show]

  # GET /events
  def index
    @activities = Activity.all.order(created_at: :desc).page(params[:page])
    respond_with @activities, meta: {total_count: Activity.all.length, page: params[:page] || 1}
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
