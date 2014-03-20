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

    context 'supports paging' do
      it 'returns specified page of activities' do
        Activity.paginates_per(1)
        activity_a = FactoryGirl.create(:beer_added_activity)
        activity_b = FactoryGirl.create(:beer_added_activity)
        get :index, {page: 1}
        assigns(:activities).should eq [activity_b]
        get :index, {page: 2}
        assigns(:activities).should eq [activity_a]
        get :index, {page: 3}
        assigns(:activities).should eq []
      end

      it 'sets metadata for total_count and page' do
        FactoryGirl.create(:beer_added_activity)
        FactoryGirl.create(:beer_added_activity)
        FactoryGirl.create(:beer_added_activity)
        controller.should_receive(:respond_with).with(anything(), {meta: {total_count: 3, page: 1}})
        get :index
      end
    end

    context 'supports filtering by type' do
      it 'assigns @activities only the activities of the specified type' do
        beer_opened_activity = FactoryGirl.create(:beer_opened_activity)
        FactoryGirl.create(:beer_added_activity)
        FactoryGirl.create(:beer_reviewed_activity)
        get :index, {type: 'BeerOpenedActivity'}
        assigns(:activities).should eq [beer_opened_activity]
      end
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