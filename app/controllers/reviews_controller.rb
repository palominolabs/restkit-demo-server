class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to @review.beer, notice: 'Review was successfully created.'
    else
      @beer = Beer.find(params[:review][:beer_id])
      render template: 'beers/show'
    end
  end

  private
    def review_params
      params.require(:review).permit(:reviewer, :rating, :comment, :beer_id)
    end
end
