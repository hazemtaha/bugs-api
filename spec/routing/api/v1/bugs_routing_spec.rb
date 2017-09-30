require 'rails_helper'

RSpec.describe Api::V1::BugsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/bugs').to route_to('api/v1/bugs#index')
    end

    it 'routes to #index' do
      expect(get: '/api/v1/bugs').to route_to('api/v1/bugs#index')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/bugs/1').to route_to('api/v1/bugs#show', number: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/bugs').to route_to('api/v1/bugs#create')
    end
  end
end
