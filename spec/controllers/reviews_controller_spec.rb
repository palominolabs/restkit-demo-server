require 'spec_helper'

describe ReviewsController do

  describe 'POST create' do
    it 'requires authentication' do
      beer = FactoryGirl.create(:beer)
      valid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: beer.id })
      controller.should_receive :require_authentication
      post :create, review: valid_attributes
    end

    context 'with valid params' do
      before do
        controller.stub(:require_authentication)
        @beer = FactoryGirl.create(:beer)
        @user = FactoryGirl.create(:user)
        @valid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: @beer.id })
        session[:user_id] = @user.id
      end

      it 'creates a new Review' do
        expect {
          post :create, review: @valid_attributes
        }.to change(Review, :count).by 1
      end

      it 'assigns a newly created review as @review' do
        post :create, review: @valid_attributes
        assigns(:review).should be_a Review
        assigns(:review).should be_persisted
      end

      it 'creates a BeerReviewedActivity' do
        post :create, review: @valid_attributes
        assigns(:review).beer_reviewed_activities.length.should be 1
        assigns(:review).beer_reviewed_activities.first.should be_a BeerReviewedActivity
      end

      it 'redirects to the associated beer' do
        post :create, review: @valid_attributes
        should redirect_to @beer
      end
    end

    context 'with invalid params' do
      before do
        controller.stub(:require_authentication)
      end

      context 'with invalid beer_id' do
        it 'raises an error' do
          Beer.any_instance.stub(:find).and_return(false)
          Review.any_instance.stub(:save).and_return(false)
          invalid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: nil })
          expect { post :create, review: invalid_attributes
          }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context 'with valid beer but invalid review params' do
        it 'redirects to beers page' do
          beer = FactoryGirl.create(:beer)
          valid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: beer.id })
          Review.any_instance.should_receive(:save).and_return(false)

          post :create, review: valid_attributes
          should render_template 'beers/show'
        end
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      @beer = FactoryGirl.create(:beer)
      @review = FactoryGirl.create(:review, { beer: @beer, beer_id: @beer.id })
    end

    it 'requires authentication' do
      controller.should_receive :require_authentication
      delete :destroy, id: @review.id
    end

    context 'the logged in user is the review creator' do
      before do
        session[:user_id] = @review.user.id
        controller.stub(:require_authentication)
      end


      it 'destroys the requested review' do
        expect {
          delete :destroy, id: @review.id
        }.to change(Review, :count).by -1
      end

      it 'assigns the target beer to @beer' do
        delete :destroy, id: @review.id

        assigns(:beer).should be_a Beer
      end

      it 'render beer#show' do
        delete :destroy, id: @review.id

        should render_template 'beers/show'
      end
    end

    context 'the logged in user is not the reviewer' do
      it 'renders beer#show and flashes an alert' do
        controller.stub(:require_authentication)
        session[:user_id] = nil
        delete :destroy, id: @review.id

        should render_template 'beers/show'
        should set_the_flash[:alert].now.to 'Failed to delete review: You are not the reviewer!'
      end
    end
  end
end
