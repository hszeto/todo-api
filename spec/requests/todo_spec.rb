require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  let!(:todos) { create_list(:todo, 12) }
  let(:todo_id) { todos.first.id }

  describe 'GET /todos' do
    it 'return todos success' do
      get '/todos'

      expect(last_response.status).to eq 200
      expect(last_response.body.size).to eq 12
    end
  end

  describe 'GET /todos/:id' do
    context 'when todo exist' do
      it 'return todo success' do
        get "/todos/#{todo_id}"

        expect(last_response.status).to eq 200
        expect(last_response.body ).not_to be_empty
        expect(last_response.body['id']).to eq(todo_id)
      end
    end

    context 'when todo does not exist' do
      it 'return 404' do
        get "/todos/1234"

        expect(last_response.status).to eq 404
        expect(last_response.body['message']).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'POST /todos' do
    let(:valid_params) {{
      title: "Buy coffee beans",
      created_by: '1'
    }}

    context 'when params is valid' do
      it 'create todo success' do
        post '/todos', params: valid_params

        expect(last_response.status).to eq 201
        expect(last_response['title']).to eq valid_params['title']
      end
    end

    context 'when params is invalid' do
      it 'create todo fail' do
        post '/todos', params: { title: 'lalala' }

        expect(last_response.status).to eq 422
        expect(last_response.body['message']).to \
          match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_params) {{ title: "Get gas" }}

    context 'when todo exist' do
      it 'update todo success' do
        put "/todos/#{todo_id}", params: valid_params

        expect(last_response.status).to eq 202
        expect(last_response.body).to be_empty
      end
    end

    context 'when todo does notexist' do
      it 'return 404' do
        put "/todos/1234", params: valid_params

        expect(last_response.status).to eq 404
        expect(last_response.body['message']).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    context 'when todo exist' do
      it 'delete todo success' do
        delete "/todos/#{todo_id}"

        expect(last_response.status).to eq 202
      end
    end

    context 'when todo does not exist' do
      it 'return 404' do
        delete "/todos/1234"

        expect(last_response.status).to eq 404
        expect(last_response.body['message']).to match(/Couldn't find Todo/)
      end
    end
  end
end
