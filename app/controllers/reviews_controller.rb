class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @review.beer, notice: 'Review was successfully created.'
    else
      @beer = Beer.find(params[:review][:beer_id])
      render template: 'beers/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @beer = @review.beer

    if @review.user == current_user
      @review.destroy
      render template: 'beers/show'
    else
      flash.now.alert = 'Failed to delete review: You are not the reviewer!'
      render template: 'beers/show'
    end

  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :beer_id)
  end
end
