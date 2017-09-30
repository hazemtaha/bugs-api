require 'rails_helper'

RSpec.describe "Bugs", type: :request do
  describe "GET /bugs" do
    it "works! (now write some real specs)" do
      get bugs_path
      expect(response).to have_http_status(200)
    end
  end
end
