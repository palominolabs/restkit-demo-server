require 'spec_helper'

describe BeersController do
  describe 'routing' do

    it 'routes to #index' do
      get('/beers').should route_to('beers#index')
      get('/beers.json').should route_to('beers#index', format: 'json')
    end

    it 'routes to #new' do
      get('/beers/new').should route_to('beers#new')
      get('/beers/new.json').should route_to('beers#new', format: 'json')
    end

    it 'routes to #show' do
      get('/beers/1').should route_to('beers#show', id: '1')
      get('/beers/1.json').should route_to('beers#show', id: '1', format: 'json')
    end

    it 'routes to #edit' do
      get('/beers/1/edit').should route_to('beers#edit', id: '1')
      get('/beers/1/edit.json').should route_to('beers#edit', id: '1', format: 'json')
    end

    it 'routes to #create' do
      post('/beers').should route_to('beers#create')
      post('/beers.json').should route_to('beers#create', format: 'json')
    end

    it 'routes to #update' do
      put('/beers/1').should route_to('beers#update', id: '1')
      put('/beers/1.json').should route_to('beers#update', id: '1', format: 'json')
    end

    it 'routes to #destroy' do
      delete('/beers/1').should route_to('beers#destroy', id: '1')
      delete('/beers/1.json').should route_to('beers#destroy', id: '1', format: 'json')
    end

    it 'routes to #open' do
      get('/beers/1/open').should route_to('beers#open',id: '1')
      get('/beers/1/open.json').should route_to('beers#open',id: '1', format: 'json')
    end
  end
end
