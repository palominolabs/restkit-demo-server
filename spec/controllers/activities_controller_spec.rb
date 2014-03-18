require 'spec_helper'

describe ActivitiesController do
  describe 'GET index' do
    it 'does not require authentication' do
      controller.should_not_receive :require_authentication
      get :index, {}
    end

    it 'assigns @activities all activities' do
      beer_added_activity = FactoryGirl.create(:beer_added_activity)
      get :index, {}
      assigns(:activities).should eq [beer_added_activity]
    end
  end

  describe 'GET show' do
    before do
      @beer_added_activity = FactoryGirl.create(:beer_added_activity)
    end

    it 'does not require authentication' do
      controller.should_not_receive :require_authentication
      get :show, {id: @beer_added_activity.id}
    end

    it 'should set @activity' do
      get :show, {id: @beer_added_activity.id}
      assigns(:activity).should be_a BeerAddedActivity
      assigns(:activity).should eql @beer_added_activity
    end
  end
end