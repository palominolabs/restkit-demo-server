class BeersController < ApplicationController
  skip_before_action :require_authentication, only: [:index, :show]
  before_action :set_beer, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /beers
  def index
    @beers = Beer.order(sort_column + ' ' + sort_direction)
  end

  # GET /beers/1
  def show
    @review = Review.new
  end

  # GET /beers/new
  def new
    @beer = Beer.new
  end

  # GET /beers/1/edit
  def edit
  end

  # POST /beers
  def create
    @beer = Beer.new(beer_params)

    if @beer.save
      redirect_to @beer, notice: 'Beer was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /beers/1
  def update
    if @beer.update(beer_params)
      redirect_to @beer, notice: 'Beer was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /beers/1
  def destroy
    @beer.destroy
    redirect_to beers_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_beer
    @beer = Beer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def beer_params
    params.require(:beer).permit(:name, :brewery)
  end

  def sort_column
    Beer.column_names.include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
