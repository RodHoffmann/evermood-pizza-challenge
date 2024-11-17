require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET /update" do
    it "returns http success" do
      get "/orders/update"
      expect(response).to have_http_status(:success)
    end
  end

end
