require 'rails_helper'

RSpec.describe 'Readiness', type: :request do
  describe 'Ping server' do
    it 'success' do
      get('/readiness')

      expect(last_response.status      ).to eq 200
      expect(last_response.body.to_json).to eq '{}'
    end
  end
end