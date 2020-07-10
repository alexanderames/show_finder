require 'rails_helper'

RSpec.describe '/searches', type: :request do
  let(:valid_attributes) do
    { 'title' => 'fargo' }
  end

  let(:invalid_attributes) do
    { title: nil }
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Search.create! valid_attributes
      get searches_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      search = Search.create! valid_attributes
      get search_url(search), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create', :vcr do
    context 'with valid parameters' do
      it 'creates a new Search' do
        headers = { 'ACCEPT' => 'application/json' }
        post '/searches', params: { title: 'batman' }, headers: headers

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Search' do
        expect do
          post searches_url,
               params: { search: invalid_attributes }, as: :json
        end.to change(Search, :count).by(0)
      end

      it 'renders a JSON response with errors for the new search' do
        post searches_url,
             params: { search: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update', :vcr do
    context 'with valid parameters' do
      it 'renders a JSON response with the search' do
        search = Search.create! valid_attributes
        patch search_url(search),
              params: { search: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the search' do
        headers = { 'ACCEPT' => 'application/json' }
        post '/searches', params: { title: nil }, headers: headers

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested search' do
      search = Search.create! valid_attributes
      expect do
        delete search_url(search), headers: valid_headers, as: :json
      end.to change(Search, :count).by(-1)
    end
  end
end
