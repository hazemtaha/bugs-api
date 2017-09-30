require 'rails_helper'

RSpec.describe Api::V1::BugsController, type: :controller do

  let(:valid_attributes) do
    {
      application_token: 124816,
      status: :_new,
      priority: :major,
      comment: 'this is a bug comment',
      state: {
        device: 'Device Name',
        os: 'OS Name',
        memory: 2048,
        storage: 128
      }
    }
  end

  let(:invalid_attributes) do
    {
      status: 2,
      priority: 50,
      comment: 'this is a bug comment',
    }
  end

  describe 'GET #show' do

    let(:bug) do
      state = FactoryGirl.create(:state)
      bug = FactoryGirl.create(:bug, state: state)
    end

    context "when bug exists" do
      it 'returns a success response' do
        get :show, params: { number: bug.number, application_token: bug.application_token }
        expect(response).to be_success
      end
    end

    context "when bug not exist" do
      it 'returns a success response' do
        get :show, params: { number: 3, application_token: '123' }
        expect(response.code).to eq('404')
      end
    end
  end

  describe 'POST #create' do
    before do
      @number ||= 0
      allow($redis).to receive(:incr).and_return((@number += 1))
      allow(Publisher).to receive(:publish).and_return(nil)
    end

    context 'with valid params' do
      before do
        post :create, params: valid_attributes
      end

      it 'returns the bug number' do
        expect(json['number']).to eq(@number)
      end

      it 'renders a JSON response with status created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new bug' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
