require 'rails_helper'

RSpec.describe 'Serializer', type: :request do
  let(:user)     { create(:user, name:'wrx02', email:'wrx02@hotmail.com', uuid:'7e87e697-65a8-4399-b84e-7e554fc2dc43') }
  let!(:todos)   { create_list(:todo, 5, created_by: user.id) }
  let(:todo_id)  { user.todos.first.id }
  let(:user2)    { create(:user) }
  let!(:todos2)  { create_list(:todo, 3, created_by: user2.id) }
  let(:todo2_id) { user2.todos.first.id }

  let(:header){{ 'Authorization' => 'eyJraWQiOiJ2RWtpZ0pwRExtSnpKelwvOHkzY1VOODNzWjZjZmlKRk9yUyt6YjloQ1V5ST0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI3ZTg3ZTY5Ny02NWE4LTQzOTktYjg0ZS03ZTU1NGZjMmRjNDMiLCJhdWQiOiI0NXA5aDU5YWZrb3BpZ3FlOXJqYW9mYzlkbCIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJldmVudF9pZCI6IjQ1MTI0Nzg1LTljODEtMTFlOC05ODI4LWZmYWZkOGQzNDc4YSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNTMzODkzOTY2LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtd2VzdC0yLmFtYXpvbmF3cy5jb21cL3VzLXdlc3QtMl9DVThHYXJqY1ciLCJjb2duaXRvOnVzZXJuYW1lIjoiN2U4N2U2OTctNjVhOC00Mzk5LWI4NGUtN2U1NTRmYzJkYzQzIiwiZXhwIjoxNTMzODk3NTY2LCJpYXQiOjE1MzM4OTM5NjYsImVtYWlsIjoid3J4MDJAaG90bWFpbC5jb20ifQ.ZMJ6AC1pMYK01gFQ9XHud3OEd7pWggPGk9MSdnm6YHF-GznETUwopQYDvmztb8ErhoCXw-DvvXTLd8ZEQIAHL6DztD7srqHPFR9xmvHaAMb2b63fsFfEgrSNqpAHCIffhPAV9xPgjOwRA3NdA_YSM1Id7venphNyyacTcxmk4aY64p91rXayOIEU-ox3aB_-lfdBSbx6MNVIb0Eg5T6HMH9yQ1FSiNmDC9gmbOO6eOcgMU7FHkW6lJjm-XXkqIMLdt5J8rSmLvsYvF5KqwLBfUmhPPZUX0Cpjbv6-g0lnqC5ajl5e3dbmMaT4d_2Oy4g16P_tpHG9yNrMMqrB0VmFw'}}

  describe 'Serializer' do
    let!(:items)  { create_list(:item, 4, todo_id: todo_id)  }
    let!(:items2) { create_list(:item, 3, todo_id: todo2_id) }

    before 'seeded with 7 items total' do
      expect(Item.all.count).to eq 7
    end

    it 'return user todos and items' do
      get "/todos/#{todo_id}", params: nil, headers: header

      expect(last_response.status).to eq 200
      expect(last_response.body['items'].size).to eq 4
    end

    it 'not return user2 items' do
      get "/todos/#{todo_id}", params: nil, headers: header

      expect(last_response.status).to eq 200
      expect(last_response.body['items'].any?{|item| item['todo_id'] == todo2_id}).to be false
    end
  end
end
