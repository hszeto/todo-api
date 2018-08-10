require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  let(:token){"eyJraWQiOiJ2RWtpZ0pwRExtSnpKelwvOHkzY1VOODNzWjZjZmlKRk9yUyt6YjloQ1V5ST0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI3ZTg3ZTY5Ny02NWE4LTQzOTktYjg0ZS03ZTU1NGZjMmRjNDMiLCJhdWQiOiI0NXA5aDU5YWZrb3BpZ3FlOXJqYW9mYzlkbCIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJldmVudF9pZCI6IjQ1MTI0Nzg1LTljODEtMTFlOC05ODI4LWZmYWZkOGQzNDc4YSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNTMzODkzOTY2LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtd2VzdC0yLmFtYXpvbmF3cy5jb21cL3VzLXdlc3QtMl9DVThHYXJqY1ciLCJjb2duaXRvOnVzZXJuYW1lIjoiN2U4N2U2OTctNjVhOC00Mzk5LWI4NGUtN2U1NTRmYzJkYzQzIiwiZXhwIjoxNTMzODk3NTY2LCJpYXQiOjE1MzM4OTM5NjYsImVtYWlsIjoid3J4MDJAaG90bWFpbC5jb20ifQ.ZMJ6AC1pMYK01gFQ9XHud3OEd7pWggPGk9MSdnm6YHF-GznETUwopQYDvmztb8ErhoCXw-DvvXTLd8ZEQIAHL6DztD7srqHPFR9xmvHaAMb2b63fsFfEgrSNqpAHCIffhPAV9xPgjOwRA3NdA_YSM1Id7venphNyyacTcxmk4aY64p91rXayOIEU-ox3aB_-lfdBSbx6MNVIb0Eg5T6HMH9yQ1FSiNmDC9gmbOO6eOcgMU7FHkW6lJjm-XXkqIMLdt5J8rSmLvsYvF5KqwLBfUmhPPZUX0Cpjbv6-g0lnqC5ajl5e3dbmMaT4d_2Oy4g16P_tpHG9yNrMMqrB0VmFw"}
  let(:expired_token){"eyJraWQiOiJ2RWtpZ0pwRExtSnpKelwvOHkzY1VOODNzWjZjZmlKRk9yUyt6YjloQ1V5ST0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI3ZTg3ZTY5Ny02NWE4LTQzOTktYjg0ZS03ZTU1NGZjMmRjNDMiLCJhdWQiOiI0NXA5aDU5YWZrb3BpZ3FlOXJqYW9mYzlkbCIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJldmVudF9pZCI6IjQ1MTI0Nzg1LTljODEtMTFlOC05ODI4LWZmYWZkOGQzNDc4YSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNTMzODkzOTY2LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtd2VzdC0yLmFtYXpvbmF3cy5jb21cL3VzLXdlc3QtMl9DVThHYXJqY1ciLCJjb2duaXRvOnVzZXJuYW1lIjoiN2U4N2U2OTctNjVhOC00Mzk5LWI4NGUtN2U1NTRmYzJkYzQzIiwiZXhwIjoxNTMzODk3NTY2LCJpYXQiOjE1MzM4OTM5NjYsImVtYWlsIjoid3J4MDJAaG90bWFpbC5jb20ifQ.ZMJ6AC1pMYK01gFQ9XHud3OEd7pWggPGk9MSdnm6YHF-GznETUwopQYDvmztb8ErhoCXw-DvvXTLd8ZEQIAHL6DztD7srqHPFR9xmvHaAMb2b63fsFfEgrSNqpAHCIffhPAV9xPgjOwRA3NdA_YSM1Id7venphNyyacTcxmk4aY64p91rXayOIEU-ox3aB_-lfdBSbx6MNVIb0Eg5T6HMH9yQ1FSiNmDC9gmbOO6eOcgMU7FHkW6lJjm-XXkqIMLdt5J8rSmLvsYvF5KqwLBfUmhPPZUX0Cpjbv6-g0lnqC5ajl5e3dbmMaT4d_2Oy4g16P_tpHG9yNrMMqrB0VmFw"}
  let(:invalid_token){"EyJraWQiOiJ2RWtpZ0pwRExtSnpKelwvOHkzY1VOODNzWjZjZmlKRk9yUyt6YjloQ1V5ST0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI3ZTg3ZTY5Ny02NWE4LTQzOTktYjg0ZS03ZTU1NGZjMmRjNDMiLCJhdWQiOiI0NXA5aDU5YWZrb3BpZ3FlOXJqYW9mYzlkbCIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJldmVudF9pZCI6IjQ1MTI0Nzg1LTljODEtMTFlOC05ODI4LWZmYWZkOGQzNDc4YSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNTMzODkzOTY2LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtd2VzdC0yLmFtYXpvbmF3cy5jb21cL3VzLXdlc3QtMl9DVThHYXJqY1ciLCJjb2duaXRvOnVzZXJuYW1lIjoiN2U4N2U2OTctNjVhOC00Mzk5LWI4NGUtN2U1NTRmYzJkYzQzIiwiZXhwIjoxNTMzODk3NTY2LCJpYXQiOjE1MzM4OTM5NjYsImVtYWlsIjoid3J4MDJAaG90bWFpbC5jb20ifQ.ZMJ6AC1pMYK01gFQ9XHud3OEd7pWggPGk9MSdnm6YHF-GznETUwopQYDvmztb8ErhoCXw-DvvXTLd8ZEQIAHL6DztD7srqHPFR9xmvHaAMb2b63fsFfEgrSNqpAHCIffhPAV9xPgjOwRA3NdA_YSM1Id7venphNyyacTcxmk4aY64p91rXayOIEU-ox3aB_-lfdBSbx6MNVIb0Eg5T6HMH9yQ1FSiNmDC9gmbOO6eOcgMU7FHkW6lJjm-XXkqIMLdt5J8rSmLvsYvF5KqwLBfUmhPPZUX0Cpjbv6-g0lnqC5ajl5e3dbmMaT4d_2Oy4g16P_tpHG9yNrMMqrB0VmFw"}

  describe 'Set User' do
    context 'When user does not exist' do
      it 'Create new user from jwt' do
        get('/todos',
          params: nil,
          headers: { 'Authorization' => token })

        expect(last_response.status).to eq 200
        expect( User.all.count  ).to eq 1
        expect( User.last.name  ).to eq 'wrx02'
        expect( User.last.email ).to eq 'wrx02@hotmail.com'
        expect( User.last.uuid  ).to eq '7e87e697-65a8-4399-b84e-7e554fc2dc43'
      end
    end

    context 'When user exist' do
      # Create an user
      let!(:user){ create(:user,
        name: 'wrx02',
        email: 'wrx02@hotmail.com',
        uuid: '7e87e697-65a8-4399-b84e-7e554fc2dc43' )}

      it 'Found user and not create new user' do
        get('/todos',
          params: nil,
          headers: { 'Authorization' => token })

        expect(last_response.status).to eq 200
        expect( User.all.count  ).to eq 1
        expect( User.last.name  ).to eq 'wrx02'
        expect( User.last.email ).to eq 'wrx02@hotmail.com'
        expect( User.last.uuid  ).to eq '7e87e697-65a8-4399-b84e-7e554fc2dc43'
      end
    end
  end

  describe 'Set User fail.' do
    context 'When token invalid.' do
      it 'Will not create new user.' do
        get('/todos',
          params: nil,
          headers: { 'Authorization' => invalid_token })

        expect( User.all.count     ).to eq 0
        expect(last_response.status).to eq 422
      end
    end

    skip 'When token expired.' do
      it 'Will not create new user.' do
        get('/todos',
          params: nil,
          headers: { 'Authorization' => expired_token })

        expect( User.all.count     ).to eq 0
        expect(last_response.status).to eq 422
      end
    end
  end
end
