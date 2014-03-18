require 'spec_helper'

describe ActivitiesController do
  describe 'routing' do

    it 'routes to #index' do
      get('/activities').should route_to('activities#index')
    end

    it 'should not route to #new' do
      get('/activities/new').should route_to('activities#show', {id: 'new'})
    end

    it 'routes to #show' do
      get('/activities/1').should route_to('activities#show', {id: '1'})
    end

    it 'does not route to #edit' do
      get('/activities/1/edit').should_not be_routable
    end

    it 'does not route to #create' do
      post('/activities').should_not be_routable
    end

    it 'does not route to #update' do
      put('/activities/1').should_not be_routable
    end

    it 'does not route to #destroy' do
      delete('/activities/1').should_not be_routable
    end
  end
end