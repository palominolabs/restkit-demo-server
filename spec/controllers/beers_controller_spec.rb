require 'spec_helper'

describe BeersController do

  describe 'GET index' do
    it 'does not require authentication' do
      controller.should_not_receive :require_authentication
      get :index, {}
    end

    it 'assigns all beers as @beers' do
      beer = FactoryGirl.create(:beer)
      get :index, {}
      assigns(:beers).should eq [beer]
    end

    context 'brewery_id specified' do
      before do
        @brewery = FactoryGirl.create(:brewery)
        @beer_in_brewery = FactoryGirl.create(:beer, {brewery: @brewery})
        FactoryGirl.create(:beer, {brewery: FactoryGirl.build(:brewery)})
        get :index, {brewery_id: @brewery.id}
      end

      it 'assigns @brewery to the specified brewery' do
        assigns(:brewery).should eq @brewery
      end

      it 'assigns all beers associated with the brewery to @beers' do
        assigns(:beers).should eq [@beer_in_brewery]
      end
    end

    context 'in_stock filter set' do
      before do
        @beer_with_inventory = FactoryGirl.create(:beer, {inventory: 1})
        FactoryGirl.create(:beer, {inventory: 0})
        get :index, {in_stock: 1}
      end

      it 'assigns all beers that have inventory > 0 to @beers' do
        assigns(:beers).should eq [@beer_with_inventory]
      end

      it 'assigns @in_stock to the string 1' do
        assigns(:in_stock).should eq '1'
      end
    end

    context 'supports paging' do
      it 'returns specified page of beers' do
        Beer.paginates_per(1)
        beer_a = FactoryGirl.create(:beer, {name: 'a'})
        beer_b = FactoryGirl.create(:beer, {name: 'b'})
        get :index, {page: 1}
        assigns(:beers).should eq [beer_a]
        get :index, {page: 2}
        assigns(:beers).should eq [beer_b]
        get :index, {page: 3}
        assigns(:beers).should eq []
      end

      it 'sets metadata for total_count and page' do
        FactoryGirl.create(:beer)
        FactoryGirl.create(:beer)
        FactoryGirl.create(:beer)
        controller.should_receive(:respond_with).with(anything(), {meta: {total_count: 3, page: 1}})
        get :index
      end
    end
  end

  describe 'GET show' do
    it 'does not require authentication' do
      controller.should_not_receive :require_authentication
      beer = FactoryGirl.create(:beer)
      get :show, {id: beer.to_param}
    end

    it 'assigns the requested beer as @beer' do
      beer = FactoryGirl.create(:beer)
      get :show, {id: beer.to_param}
      assigns(:beer).should eq beer
    end

    it 'assigns a new review to @review' do
      beer = FactoryGirl.create(:beer)
      get :show, {id: beer.to_param}
      assigns(:review).should be_a_new Review
    end
  end

  describe 'GET new' do
    it 'requires authentication' do
      controller.should_receive :require_authentication
      get :new, {}
    end

    it 'assigns a new beer as @beer' do
      controller.stub(:require_authentication)
      get :new, {}
      assigns(:beer).should be_a_new Beer
    end
  end

  describe 'GET edit' do
    it 'requires authentication' do
      controller.should_receive :require_authentication
      get :new, {}
    end

    it 'assigns the requested beer as @beer' do
      controller.stub(:require_authentication)
      beer = FactoryGirl.create(:beer)
      get :edit, {id: beer.to_param}
      assigns(:beer).should eq beer
    end
  end
  
  describe 'POST create' do
    it 'requires authentication' do
      controller.should_receive :require_authentication
      post :create, { beer_form: FactoryGirl.attributes_for(:beer_form) }
    end

    context 'with valid params' do
      before do
        user = FactoryGirl.build(:user)
        controller.stub(:current_user).and_return(user)
        controller.stub(:require_authentication)
        brewery = FactoryGirl.create(:brewery)
        @beer_form_attributes = FactoryGirl.attributes_for(:beer_form, {brewery_id: brewery.id})
      end

      it 'creates a new Beer' do
        expect {
          post :create, {beer_form: @beer_form_attributes}
        }.to change(Beer, :count).by 1
      end

      it 'assigns a newly created beer as @beer' do
        post :create, {beer_form: @beer_form_attributes}
        assigns(:beer).should be_a Beer
        assigns(:beer).should be_persisted
      end

      it 'creates a beer_added_activity' do
        post :create, {beer_form: @beer_form_attributes}
        assigns(:beer).beer_added_activities.length.should eql 1
        assigns(:beer).beer_added_activities.first.should be_a BeerAddedActivity
      end

      it 'redirects to the created beer' do
        post :create, {beer_form: @beer_form_attributes}
        should redirect_to Beer.last
      end

      context 'with invalid beer_added_activity' do
        it 're-renders the \'new\' template' do
          controller.stub(:current_user).and_return(nil)
          post :create, {beer_form: @beer_form_attributes}
          should render_template :new
        end

        it 'assigns @beers a new beer' do
          controller.stub(:current_user).and_return(nil)
          post :create, {beer_form: @beer_form_attributes}
          assigns(:beer).should be_a_new Beer
        end
      end
    end

    context 'with invalid params' do
      before do
        controller.stub(:require_authentication)
      end

      it 'assigns a newly created but unsaved beer_form as @beer_form' do
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        post :create, {beer_form: { name: 'invalid value' }}
        assigns(:beer_form).should be_a BeerForm
      end

      it 're-renders the \'new\' template' do
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        post :create, {beer_form: { name: 'invalid value' }}
        should render_template :new
      end
    end
  end

  describe 'PUT update' do
    it 'requires authentication' do
      @beer = FactoryGirl.create(:beer)
      controller.should_receive :require_authentication
      put :update, {id: @beer.to_param, beer_form: FactoryGirl.attributes_for(:beer_form)}
    end

    context 'with valid params' do
      before do
        controller.stub(:require_authentication)
        @beer = FactoryGirl.create(:beer)
      end

      it 'updates the requested beer' do
        Beer.any_instance.should_receive(:save)
        put :update, {id: @beer.to_param, beer_form: FactoryGirl.attributes_for(:beer_form, { name: 'Egregious' })}
      end

      it 'assigns the requested beer as @beer' do
        put :update, {id: @beer.to_param, beer_form: FactoryGirl.attributes_for(:beer_form)}
        assigns(:beer).should be_a Beer
        assigns(:beer).id.should eql @beer.id
      end

      it 'redirects to the beer' do
        put :update, {id: @beer.to_param, beer_form: FactoryGirl.attributes_for(:beer_form)}
        should redirect_to @beer
      end
    end

    context 'with invalid params' do
      before do
        controller.stub(:require_authentication)
        @beer = FactoryGirl.create(:beer)
      end

      it 'assigns the beer as @beer' do
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        put :update, {id: @beer.to_param, beer_form: { name: 'invalid value' }}
        assigns(:beer).should eq @beer
      end

      it 're-renders the \'edit\' template' do
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        put :update, {id: @beer.to_param, beer_form: { name: 'invalid value' }}
        should render_template :edit
      end
    end
  end

  describe 'GET open' do
    before do
      @beer = FactoryGirl.create(:beer)
    end
    it 'requires authentication' do
      controller.should_receive :require_authentication
      get :open, {id: @beer.to_param, beer: @beer}
    end

    context 'with authorized user' do
      before do
        controller.stub(:require_authentication)
        user = FactoryGirl.build(:user)
        controller.stub(:current_user).and_return(user)
      end

      it 'assigns @beer to the specified beer' do
        get :open, {id: @beer.id, beer: @beer}
        assigns(:beer).should be_a Beer
        assigns(:beer).name.should eql @beer.name
      end

      it 'assigns  @review to a new review' do
        get :open, {id: @beer.id, beer: @beer}
        assigns(:review).should be_new_record
      end

      it 'renders beers#show' do
        get :open, {id: @beer.id, beer: @beer}
        should redirect_to(@beer)
      end

      context 'with one or more beers in the inventory' do
        before do
          @beer = FactoryGirl.create(:beer, {name: 'test_beer', inventory: 2})
        end

        it 'decrements the inventory' do
          get :open, {id: @beer.id, beer: @beer}
          assigns(:beer).inventory.should eql 1
        end

        it 'creates a beer_opened_activity' do
          get :open, {id: @beer.id, beer: @beer}
          assigns(:beer).beer_opened_activities.length.should eql 1
          assigns(:beer).beer_opened_activities.first.should be_a BeerOpenedActivity
        end

        it 'flashes a notice' do
          get :open, {id: @beer.id, beer: @beer}
          should set_the_flash[:notice].to 'A bottle of test_beer was successfully opened.'
        end

        context 'with invalid parameters' do
          it 'flashes a failure alert' do
            Beer.any_instance.stub(:save).and_return(false)
            get :open, {id: @beer.id, beer: @beer}
            should set_the_flash[:alert].to 'Failed to open a bottle of test_beer.'
          end
        end
      end

      context 'with zero beers in the inventory' do
        before do
          @beer = FactoryGirl.create(:beer, {name: 'test_beer', inventory: 0})
        end

        it 'flashes an alert' do
          get :open, {id: @beer.id, beer: @beer}
          should set_the_flash[:alert].to 'No bottles of test_beer left to open.'
        end
      end

      context 'with invalid beer_opened_activity' do
        it 'flashes an alert' do
          controller.stub(:current_user).and_return(nil)
          @beer = FactoryGirl.create(:beer, {name: 'test_beer', inventory: 2})
          get :open, {id: @beer.id, beer: @beer}
          should set_the_flash[:alert].to 'Failed to open a bottle of test_beer.'
        end
      end
    end
  end

  describe 'DELETE destroy' do
    it 'requires authentication' do
      controller.should_receive :require_authentication
      get :new, {}
    end

    it 'destroys the requested beer' do
      controller.stub(:require_authentication)
      beer = FactoryGirl.create(:beer)
      expect {
        delete :destroy, {id: beer.to_param}
      }.to change(Beer, :count).by -1
    end

    it 'redirects to the beers list' do
      controller.stub(:require_authentication)
      beer = FactoryGirl.create(:beer)
      delete :destroy, {id: beer.to_param}
      should redirect_to beers_url
    end
  end
end
