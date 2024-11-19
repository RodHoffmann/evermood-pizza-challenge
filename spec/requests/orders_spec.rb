require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'GET /orders' do
    let!(:open_order) { create(:order, state: 'OPEN', created_at: Time.zone.now) }
    let!(:closed_order) { create(:order, state: 'CLOSED') }

    it 'renders the index view with only open orders' do
      get orders_path

      expect(response.body).to include(open_order.id.to_s)
      expect(response.body).to include(open_order.created_at.strftime('%Y-%m-%d'))

      expect(response.body).not_to include(closed_order.id.to_s)
    end
  end

  describe 'PATCH /orders/:id' do
    let!(:order) { create(:order, state: 'OPEN') }

    it 'marks the order as CLOSED' do
      patch "/orders/#{order.id}", params: { order: { state: 'CLOSED' } }
      puts response.body
      expect(response).to have_http_status(:found)
      expect(order.reload.state).to eq('CLOSED')
    end
  end
end
