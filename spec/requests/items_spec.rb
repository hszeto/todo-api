require 'rails_helper'

RSpec.describe 'Items API' do
  let!(:todo) { create(:todo) }
  let!(:items) { create_list(:item, 12, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }

  describe 'GET /todos/:todo_id/items' do
    context 'when todo exists' do
      it 'return todo items success' do
        get "/todos/#{todo_id}/items"

        expect(last_response.status).to eq 200
        expect(last_response.body.size ).to eq 12
      end
    end

    context 'when todo does not exist' do
      it 'return 404' do
        get '/todos/1234/items'

        expect(last_response.status).to eq 404
        expect(last_response.body['message']).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'GET /todos/:todo_id/items/:id' do
    context 'when todo item exists' do
      it 'return todo item' do
        get "/todos/#{todo_id}/items/#{id}"

        expect(last_response.status).to eq 200
        expect(last_response.body['id']).to eq id
        expect(last_response.body['name']).to eq items.first.name
      end
    end

    context 'when todo item does not exist' do
      it 'return 404' do
        get "/todos/#{todo_id}/items/1234"

        expect(last_response.status).to eq 404
        expect(last_response.body['message']).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /todos/:todo_id/items' do
    let(:valid_params) {{
      name: "Buy coffee beans",
      completed: false
    }}

    let(:invalid_params) {{ completed: false }}

    it 'create item success' do 
      post "/todos/#{todo_id}/items", params: valid_params

      expect(last_response.status).to eq 201
      expect(last_response['name']).to eq valid_params['name']
    end

    it 'create item fail by invalid params' do 
      post "/todos/#{todo_id}/items", params: invalid_params

      expect(last_response.status).to eq 422
      expect(last_response.body['message']).to match(/Name can't be blank/)
    end
  end

  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_params) {{ name: "Get premium gas" }}
    let(:invalid_params) {{ name: "" }}

    it 'update item success' do
      put "/todos/#{todo_id}/items/#{id}", params: valid_params

      expect(last_response.status).to eq 202
      expect(last_response['name']).to eq valid_params['name']
    end

    it 'update item fail by invalid_params' do
      put "/todos/#{todo_id}/items/#{id}", params: invalid_params

      expect(last_response.status).to eq 422
      expect(last_response.body['message']).to match(/Name can't be blank/)
    end
  end

  describe 'DELETE /todos/:id' do
    it 'success' do
      delete "/todos/#{todo_id}/items/#{id}"

      expect(last_response.status).to eq 202
    end

    it 'fail by unknown todo id' do
      delete "/todos/1234/items/#{id}"

      expect(last_response.status).to eq 404
      expect(last_response.body['message']).to match(/Couldn't find Todo/)
    end

    it 'fail by unknown item id' do
      delete "/todos/#{todo_id}/items/1234"

      expect(last_response.status).to eq 404
      expect(last_response.body['message']).to match(/Couldn't find Item/)
    end
  end
end
