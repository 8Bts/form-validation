require 'rails_helper'

RSpec.describe 'Post request to /authors', type: :request do
  it 'sends request with valid params and get status 200' do
    post '/authors',
         params: {
           first_name: 'Bill',
           last_name: 'Gates',
           email: 'gatess@ll.cc'
         }
    expect(response).to have_http_status(:ok)
  end

  it 'sends request with invalid params and get status 422' do
    post '/authors', params: nil
    expect(response).to have_http_status(422)

    post '/authors',
         params: {
           first_name: nil,
           last_name: 'Gates',
           email: 'gatess@ll.cc'
         }
    expect(response).to have_http_status(422)

    post '/authors',
         params: {
           first_name: 'Bill',
           last_name: nil,
           email: 'gatess@ll.cc'
         }
    expect(response).to have_http_status(422)

    post '/authors',
         params: {
           first_name: 'Bill',
           last_name: 'Gates',
           email: nil
         }
    expect(response).to have_http_status(422)

    post '/authors',
         params: {
           first_name: 'Bill',
           last_name: 'Gates',
           email: 'gatess@'
         }
    expect(response).to have_http_status(422)
  end
end
