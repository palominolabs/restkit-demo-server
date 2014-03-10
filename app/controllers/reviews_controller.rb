class ReviewsController < ApplicationController

  def create
    @beer = Beer.find(params[:beer_id])
    @review = @beer.reviews.new(review_params)

    if @review.save
      redirect_to @review.beer, notice: 'Review was successfully created.'
    else
      render template: 'beer/show'
    end
  end

  private
    def review_params
      params.require(:review).permit(:reviewer, :rating, :comment)
    end
end
