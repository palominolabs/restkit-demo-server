require 'spec_helper'

describe BreweriesController do
  describe 'routing' do

    it 'routes to #index' do
      get('/breweries').should route_to('breweries#index')
      get('/breweries.json').should route_to('breweries#index', format: 'json')
    end

    it 'routes to #new' do
      get('/breweries/new').should route_to('breweries#new')
      get('/breweries/new.json').should route_to('breweries#new', format: 'json')
    end

    it 'routes to #show' do
      get('/breweries/1').should route_to('breweries#show', id: '1')
      get('/breweries/1.json').should route_to('breweries#show', id: '1', format: 'json')
    end

    it 'routes to #edit' do
      get('/breweries/1/edit').should route_to('breweries#edit', id: '1')
      get('/breweries/1/edit.json').should route_to('breweries#edit', id: '1', format: 'json')
    end

    it 'routes to #create' do
      post('/breweries').should route_to('breweries#create')
      post('/breweries.json').should route_to('breweries#create', format: 'json')
    end

    it 'routes to #update' do
      put('/breweries/1').should route_to('breweries#update', id: '1')
      put('/breweries/1.json').should route_to('breweries#update', id: '1', format: 'json')
    end

    it 'routes to #destroy' do
      delete('/breweries/1').should route_to('breweries#destroy', id: '1')
      delete('/breweries/1.json').should route_to('breweries#destroy', id: '1', format: 'json')
    end

  end
end
