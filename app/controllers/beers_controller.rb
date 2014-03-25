class BeersController < ApplicationController
  skip_before_action :require_authentication, only: [:index, :show]
  before_action :set_beer, only: [:show, :edit, :update, :destroy, :open]
  before_action :set_breweries, only: [:new, :edit, :create, :update]
  after_filter :set_access_control, only: [:index]
  helper_method :sort_column, :sort_direction

  # GET /beers
  def index
    if params[:brewery_id]
      @brewery = Brewery.find(params[:brewery_id])
      beers = Beer.where(brewery: @brewery)
    else
      beers = Beer.all
    end

    if params[:in_stock] == '1'
      @in_stock = '1'
      beers.where!('inventory > 0')
    end

    @beers = beers.order(sort_column + ' ' + sort_direction).page(params[:page])
    respond_with @beers, meta: {total_count: beers.length, page: params[:page] || 1}
  end

  # GET /beers/1
  def show
    @review = Review.new
    respond_with @brewery
  end

  # GET /beers/new
  def new
    @beer = Beer.new
    @beer_form = BeerForm.new
  end

  # GET /beers/1/edit
  def edit
    @beer_form = BeerForm.new({
        name: @beer.name,
        brewery_id: @beer.brewery_id,
        inventory: @beer.inventory
                              })
  end

  # POST /beers
  def create
    @beer_form = BeerForm.new(beer_form_params)
    if @beer_form.valid?
      @beer = Beer.new({
                           name: @beer_form.name,
                           brewery_id: @beer_form.brewery_id,
                           inventory: @beer_form.inventory
                       })
      @beer.beer_added_activities << BeerAddedActivity.new(beer: @beer, user: current_user)

      if @beer.save
        if @beer_form.thumbnail
          if upload_s3_image(@beer_form.thumbnail, @beer)
            redirect_to @beer, notice: 'Beer was successfully created.' and return
          else
            render action: :edit and return
          end
        else
          redirect_to @beer, notice: 'Beer was successfully created.' and return
        end
      end
    end
    @beer = Beer.new
    render action: :new
  end

  # PATCH/PUT /beers/1
  def update
    @beer_form = BeerForm.new(beer_form_params)
    if @beer_form.valid?

      @beer.name = @beer_form.name
      @beer.brewery_id = @beer_form.brewery_id
      @beer.inventory = @beer_form.inventory

      if @beer.save
        if @beer_form.thumbnail
          if upload_s3_image(@beer_form.thumbnail, @beer)
            redirect_to @beer, notice: 'Beer was successfully updated.' and return
          end
        else
          redirect_to @beer, notice: 'Beer was successfully updated.' and return
        end
      end
    end
    render action: :edit
  end

    # DELETE /beers/1
    def destroy
      @beer.destroy
      redirect_to beers_url
    end

    # GET OPEN /beer/1/open
    def open
      if @beer.inventory > 0
        @beer.decrement(:inventory)
        @beer.beer_opened_activities << BeerOpenedActivity.new(user: current_user)

        if @beer.save
          flash.notice = "A bottle of #{@beer.name} was successfully opened."
        else
          flash.alert = "Failed to open a bottle of #{@beer.name}."
        end
      else
        flash.alert = "No bottles of #{@beer.name} left to open."
      end

      @review = Review.new
      redirect_to @beer
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    def set_breweries
      @breweries = Brewery.order(:name)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_form_params
      params.require(:beer_form).permit(:name, :brewery_id, :inventory, :thumbnail)
    end

    def sort_column
      Beer.column_names.include?(params[:sort]) ? params[:sort] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def upload_s3_image(image, beer)
      begin
        AwsService.upload_beer_image(image, beer)
      rescue AwsService::BeerSaveFailed => e
        flash.now.alert = 'Failed to save image, please try again'
      rescue AwsService::ImageUploadFailed => e
        flash.now.alert = 'Failed to upload image'
      rescue AwsService::InvalidImageFormat => e
        flash.now.alert = 'Invalid Format: Only JPEGs and PNGs are supported'
      rescue AwsService::NoImageProvided => e
        flash.now.alert = 'No image provided'
      end
    end
  end
