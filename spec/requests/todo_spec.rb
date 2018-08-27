require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  let(:user)    { create(:user, name:'wrx02', email:'wrx02@hotmail.com', uuid:'7e87e697-65a8-4399-b84e-7e554fc2dc43') }
  let!(:todos)  { create_list(:todo, 5, created_by: user.id) }
  let(:todo_id) { user.todos.first.id }
  let(:user2)   { create(:user) }
  let!(:todos2) { create_list(:todo, 3, created_by: user2.id) }
  let(:user2_todo_id) { user2.todos.first.id }

  let(:header){{ 'Authorization' => 'eyJraWQiOiJ2RWtpZ0pwRExtSnpKelwvOHkzY1VOODNzWjZjZmlKRk9yUyt6YjloQ1V5ST0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI3ZTg3ZTY5Ny02NWE4LTQzOTktYjg0ZS03ZTU1NGZjMmRjNDMiLCJhdWQiOiI0NXA5aDU5YWZrb3BpZ3FlOXJqYW9mYzlkbCIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJldmVudF9pZCI6IjQ1MTI0Nzg1LTljODEtMTFlOC05ODI4LWZmYWZkOGQzNDc4YSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNTMzODkzOTY2LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtd2VzdC0yLmFtYXpvbmF3cy5jb21cL3VzLXdlc3QtMl9DVThHYXJqY1ciLCJjb2duaXRvOnVzZXJuYW1lIjoiN2U4N2U2OTctNjVhOC00Mzk5LWI4NGUtN2U1NTRmYzJkYzQzIiwiZXhwIjoxNTMzODk3NTY2LCJpYXQiOjE1MzM4OTM5NjYsImVtYWlsIjoid3J4MDJAaG90bWFpbC5jb20ifQ.ZMJ6AC1pMYK01gFQ9XHud3OEd7pWggPGk9MSdnm6YHF-GznETUwopQYDvmztb8ErhoCXw-DvvXTLd8ZEQIAHL6DztD7srqHPFR9xmvHaAMb2b63fsFfEgrSNqpAHCIffhPAV9xPgjOwRA3NdA_YSM1Id7venphNyyacTcxmk4aY64p91rXayOIEU-ox3aB_-lfdBSbx6MNVIb0Eg5T6HMH9yQ1FSiNmDC9gmbOO6eOcgMU7FHkW6lJjm-XXkqIMLdt5J8rSmLvsYvF5KqwLBfUmhPPZUX0Cpjbv6-g0lnqC5ajl5e3dbmMaT4d_2Oy4g16P_tpHG9yNrMMqrB0VmFw'}}

  describe 'GET /todos' do
    it 'return todos success' do
      get '/todos', params: nil, headers: header

      expect(last_response.status).to eq 200
      expect(last_response.body.size).to eq 5
    end
  end

  describe 'GET /todos/:id' do
    context 'when todo exist' do
      it 'return todo success' do
        get "/todos/#{todo_id}", params: nil, headers: header

        expect(last_response.status).to eq 200
        expect(last_response.body ).not_to be_empty
        expect(last_response.body['id']).to eq(todo_id)
      end
    end

    context 'when todo does not exist' do
      it 'return 404' do
        get "/todos/1234", params: nil, headers: header

        expect(last_response.status).to eq 404
        expect(last_response.body['message']).to match(/Couldn't find Todo/)
      end
    end

    context 'when accessing user2 todos' do
      it 'return 404' do
        get "/todos/#{user2_todo_id}", params: nil, headers: header

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
        post '/todos', params: valid_params, headers: header

        expect(last_response.status).to eq 200
        expect(last_response['title']).to eq valid_params['title']
      end
    end

    context 'when params is invalid' do
      it 'create todo fail' do
        post '/todos', params: {}, headers: header

        expect(last_response.status).to eq 422
        expect(last_response.body['message']).to \
          match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_params) {{ title: "Get gas" }}

    context 'when todo exist' do
      it 'update todo success' do
        put "/todos/#{todo_id}", params: valid_params, headers: header

        expect(last_response.status).to eq 200
        expect(last_response.body.size).to eq 5
      end
    end

    context 'when todo does not exist' do
      it 'return 404' do
        put '/todos/1234', params: valid_params, headers: header

        expect(last_response.status).to eq 404
        expect(last_response.body['message']).to match(/Couldn't find Todo/)
      end
    end

    context 'when accessing user2 todos' do
      it 'return 404' do
        put "/todos/#{user2_todo_id}", params: nil, headers: header

        expect(last_response.status).to eq 404
        expect(last_response.body['message']).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    context 'when todo exist' do
      it 'delete todo success' do
        delete "/todos/#{todo_id}", headers: header

        expect(last_response.status).to eq 200
      end
    end

    context 'when todo does not exist' do
      it 'return 404' do
        delete '/todos/1234', headers: header

        expect(last_response.status).to eq 404
        expect(last_response.body['message']).to match(/Couldn't find Todo/)
      end
    end

    context 'when accessing user2 todos' do
      it 'return 404' do
        delete "/todos/#{user2_todo_id}", params: nil, headers: header

        expect(last_response.status).to eq 404
        expect(last_response.body['message']).to match(/Couldn't find Todo/)
      end
    end
  end
end
