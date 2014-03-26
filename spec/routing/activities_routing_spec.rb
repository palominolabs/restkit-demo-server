require 'spec_helper'

describe ActivitiesController do
  describe 'routing' do

    it 'routes to #index' do
      get('/activities').should route_to('activities#index')
      get('/activities.json').should route_to('activities#index', {format: 'json'})
    end

    it 'should not route to #new' do
      get('/activities/new').should route_to('activities#show', {id: 'new'})
      get('/activities/new.json').should route_to('activities#show', {id: 'new', format: 'json'})
    end

    it 'routes to #show' do
      get('/activities/1').should route_to('activities#show', {id: '1'})
      get('/activities/1.json').should route_to('activities#show', {id: '1', format: 'json'})
    end

    it 'does not route to #edit' do
      get('/activities/1/edit').should_not be_routable
      get('/activities/1/edit.json').should_not be_routable
    end

    it 'does not route to #create' do
      post('/activities').should_not be_routable
      post('/activities.json').should_not be_routable
    end

    it 'does not route to #update' do
      put('/activities/1').should_not be_routable
      put('/activities/1.json').should_not be_routable
    end

    it 'does not route to #destroy' do
      delete('/activities/1').should_not be_routable
      delete('/activities/1.json').should_not be_routable
    end
  end
end