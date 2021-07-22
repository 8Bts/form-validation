require 'rails_helper'

RSpec.describe 'Post request to /authors', type: :request do
  it 'sends HTTP request with valid data and receives response status 201' do
    data = {
      first_name: 'Tim',
      last_name: 'Cooper',
      email: 'tim@cooper.cm'
    }
    VCR.turned_off do
      stub_request(:post, "https://gorest.co.in/public/v1/users?access-token=#{Api::AUTH_KEY}")
        .with(
          body: '{"name":"Tim Cooper","gender":"male","email":"tim@cooper.cm","status":"active"}',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Faraday v1.5.1'
          }
        )
        .to_return(status: 201, body: '', headers: {})
      expect(Api.send_data(data).status).to eql(201)
    end
  end

  it 'sends HTTP request with invalid data and raises Faraday::UnprocessableEntityError(422)' do
    data = {
      first_name: nil,
      last_name: nil,
      email: 'nil@nil.com'
    }
    VCR.turned_off do
      stub_request(:post, "https://gorest.co.in/public/v1/users?access-token=#{Api::AUTH_KEY}")
        .with(
          body: '{"name":" ","gender":"male","email":"nil@nil.com","status":"active"}',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Faraday v1.5.1'
          }
        )
        .to_return(status: 422, body: '', headers: {})
      expect { Api.send_data(data).status }.to raise_error(Faraday::UnprocessableEntityError)
    end
  end

  it 'sends HTTP request with already in use email and raises Faraday::UnprocessableEntityError(422)' do
    data = {
      first_name: 'Some',
      last_name: 'One',
      email: 'tim@cooper.cm'
    }
    VCR.turned_off do
      stub_request(:post, "https://gorest.co.in/public/v1/users?access-token=#{Api::AUTH_KEY}")
        .with(
          body: '{"name":"Some One","gender":"male","email":"tim@cooper.cm","status":"active"}',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Faraday v1.5.1'
          }
        )
        .to_return(status: 422, body: '', headers: {})
      expect { Api.send_data(data) }.to raise_error(Faraday::UnprocessableEntityError)
    end
  end
end
