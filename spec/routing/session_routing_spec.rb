require 'spec_helper'

describe SessionsController do
  describe 'routing' do

    it 'does not route to #index' do
      get('/sessions').should_not be_routable
      get('/sessions.json').should_not be_routable
    end

    it 'routes to #new' do
      get('/sessions/new').should  route_to('sessions#new')
      get('/sessions/new.json').should  route_to 'sessions#new', format: 'json'
    end

    it 'routes sign_up to #new' do
      get('/log_in').should route_to('sessions#new')
      get('/log_in.json').should route_to 'sessions#new', format: 'json'
    end

    it 'does not route to #show' do
      get('/sessions/1').should_not be_routable
      get('/sessions/1.json').should_not be_routable
    end

    it 'does not route to #edit' do
      get('/sessions/1/edit').should_not be_routable
      get('/sessions/1/edit.json').should_not be_routable
    end

    it 'routes to #create' do
      post('/sessions').should route_to('sessions#create')
      post('/sessions.json').should route_to 'sessions#create', format: 'json'
    end

    it 'does not route to #update' do
      put('/sessions/1').should_not be_routable
      put('/sessions/1.json').should_not be_routable
    end

    it 'routes to #destroy' do
      delete('/sessions/1').should route_to('sessions#destroy', id: '1')
      delete('/sessions/1.json').should route_to 'sessions#destroy', id: '1', format: 'json'
    end

    it 'routes log_out to #destroy' do
      get('/log_out').should route_to('sessions#destroy')
      get('/log_out.json').should route_to 'sessions#destroy', format: 'json'
    end

  end
end
