require 'rails_helper'

RSpec.describe RequestJob, type: :job do
  include ActiveJob::TestHelper

  data = {
    first_name: 'Tony',
    last_name: 'Cooper',
    email: 'tony@cooper.cm'
  }

  subject(:job) { described_class.perform_later(data) }

  it 'calls Api.send_data when performed' do
    VCR.turned_off do
      stub_request(:post, "https://gorest.co.in/public/v1/users?access-token=#{Api::AUTH_KEY}")
        .with(
          body: '{"name":"Tony Cooper","gender":"male","email":"tony@cooper.cm","status":"active"}',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Faraday v1.5.1'
          }
        )
        .to_return(status: 201, body: '', headers: {})
      expect(Api).to receive(:send_data).with(data)
      perform_enqueued_jobs { job }
    end
  end
end
