require 'spec_helper'

describe ReviewsController do
  describe 'routing' do

    it 'does not route to #index' do
      get('/reviews').should_not be_routable
      get('/reviews.json').should_not be_routable
    end

    it 'does not route to #new' do
      get('/reviews/new').should_not be_routable
      get('/reviews/new.json').should_not be_routable
    end

    it 'does not route to #show' do
      get('/reviews/1').should_not be_routable
      get('/reviews/1.json').should_not be_routable
    end

    it 'does not route to #edit' do
      get('/reviews/1/edit').should_not be_routable
      get('/reviews/1/edit.json').should_not be_routable
    end

    it 'routes to #create' do
      post('/reviews').should route_to('reviews#create')
      post('/reviews.json').should route_to('reviews#create', format: 'json')
    end

    it 'does not route to #update' do
      put('/reviews/1').should_not be_routable
      put('/reviews/1.json').should_not be_routable
    end

    it 'routes to #destroy' do
      delete('/reviews/1').should route_to('reviews#destroy', id: '1')
      delete('/reviews/1.json').should route_to('reviews#destroy', id: '1', format: 'json')
    end

  end
end
