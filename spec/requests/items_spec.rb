require 'rails_helper'

RSpec.describe 'Items API' do
  let!(:todo) { create(:todo) }
  let!(:items) { create_list(:item, 12, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }

  let(:header){{ 'Authorization' => 'eyJraWQiOiJ2RWtpZ0pwRExtSnpKelwvOHkzY1VOODNzWjZjZmlKRk9yUyt6YjloQ1V5ST0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI3ZTg3ZTY5Ny02NWE4LTQzOTktYjg0ZS03ZTU1NGZjMmRjNDMiLCJhdWQiOiI0NXA5aDU5YWZrb3BpZ3FlOXJqYW9mYzlkbCIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJldmVudF9pZCI6IjQ1MTI0Nzg1LTljODEtMTFlOC05ODI4LWZmYWZkOGQzNDc4YSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNTMzODkzOTY2LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtd2VzdC0yLmFtYXpvbmF3cy5jb21cL3VzLXdlc3QtMl9DVThHYXJqY1ciLCJjb2duaXRvOnVzZXJuYW1lIjoiN2U4N2U2OTctNjVhOC00Mzk5LWI4NGUtN2U1NTRmYzJkYzQzIiwiZXhwIjoxNTMzODk3NTY2LCJpYXQiOjE1MzM4OTM5NjYsImVtYWlsIjoid3J4MDJAaG90bWFpbC5jb20ifQ.ZMJ6AC1pMYK01gFQ9XHud3OEd7pWggPGk9MSdnm6YHF-GznETUwopQYDvmztb8ErhoCXw-DvvXTLd8ZEQIAHL6DztD7srqHPFR9xmvHaAMb2b63fsFfEgrSNqpAHCIffhPAV9xPgjOwRA3NdA_YSM1Id7venphNyyacTcxmk4aY64p91rXayOIEU-ox3aB_-lfdBSbx6MNVIb0Eg5T6HMH9yQ1FSiNmDC9gmbOO6eOcgMU7FHkW6lJjm-XXkqIMLdt5J8rSmLvsYvF5KqwLBfUmhPPZUX0Cpjbv6-g0lnqC5ajl5e3dbmMaT4d_2Oy4g16P_tpHG9yNrMMqrB0VmFw'}}

  describe 'GET /todos/:todo_id/items' do
    context 'when todo exists' do
      it 'return todo items success' do
        get "/todos/#{todo_id}/items", params: nil, headers: header

        expect(last_response.status).to eq 200
        expect(last_response.body.size ).to eq 12
      end
    end

    context 'when todo does not exist' do
      it 'return 404' do
        get '/todos/1234/items', params: nil, headers: header

        expect(last_response.status).to eq 404
        expect(last_response.body['message']).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'GET /todos/:todo_id/items/:id' do
    context 'when todo item exists' do
      it 'return todo item' do
        get "/todos/#{todo_id}/items/#{id}", params: nil, headers: header

        expect(last_response.status).to eq 200
        expect(last_response.body['id']).to eq id
        expect(last_response.body['name']).to eq items.first.name
      end
    end

    context 'when todo item does not exist' do
      it 'return 404' do
        get "/todos/#{todo_id}/items/1234", params: nil, headers: header

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
      post "/todos/#{todo_id}/items", params: valid_params, headers: header

      expect(last_response.status).to eq 201
      expect(last_response['name']).to eq valid_params['name']
    end

    it 'create item fail by invalid params' do 
      post "/todos/#{todo_id}/items", params: invalid_params, headers: header

      expect(last_response.status).to eq 422
      expect(last_response.body['message']).to match(/Name can't be blank/)
    end
  end

  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_params) {{ name: "Get premium gas" }}
    let(:invalid_params) {{ name: "" }}

    it 'update item success' do
      put "/todos/#{todo_id}/items/#{id}", params: valid_params, headers: header

      expect(last_response.status).to eq 202
      expect(last_response['name']).to eq valid_params['name']
    end

    it 'update item fail by invalid_params' do
      put "/todos/#{todo_id}/items/#{id}", params: invalid_params, headers: header

      expect(last_response.status).to eq 422
      expect(last_response.body['message']).to match(/Name can't be blank/)
    end
  end

  describe 'DELETE /todos/:id' do
    it 'success' do
      delete "/todos/#{todo_id}/items/#{id}", headers: header

      expect(last_response.status).to eq 202
    end

    it 'fail by unknown todo id' do
      delete "/todos/1234/items/#{id}", headers: header

      expect(last_response.status).to eq 404
      expect(last_response.body['message']).to match(/Couldn't find Todo/)
    end

    it 'fail by unknown item id' do
      delete "/todos/#{todo_id}/items/1234", headers: header

      expect(last_response.status).to eq 404
      expect(last_response.body['message']).to match(/Couldn't find Item/)
    end
  end
end
