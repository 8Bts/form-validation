require 'rails_helper'

RSpec.describe 'Post request to /authors', type: :request, vcr: { record: :new_episodes } do
  it 'sends HTTP request with valid data and receives response status 201' do
    data = {
      first_name: 'Tim',
      last_name: 'Cooper',
      email: 'tim@cooper.cm'
    }
    expect(Api.send_data(data).status).to eql(201)
  end

  it 'sends HTTP request with invalid data and raises Faraday::UnprocessableEntityError(422)' do
    data = {
      first_name: nil,
      last_name: nil,
      email: 'nil@nil.com'
    }
    expect { Api.send_data(data) }.to raise_error(Faraday::UnprocessableEntityError)
  end

  it 'sends HTTP request with already in use email and raises Faraday::UnprocessableEntityError(422)' do
    data = {
      first_name: 'Some',
      last_name: 'One',
      email: 'tim@cooper.cm'
    }
    expect { Api.send_data(data) }.to raise_error(Faraday::UnprocessableEntityError)
  end
end
