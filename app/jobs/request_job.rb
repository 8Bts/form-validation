require 'faraday'

class RequestJob < ApplicationJob
  queue_as :default
  retry_on Faraday::TimeoutError

  rescue_from(Faraday::ClientError) do |e|
    data = JSON.parse(e.response[:body])['data'][0]
    puts ''
    puts "Error ##{e.response[:status]}. #{data['field']} #{data['message']}"
    puts ''
  end

  rescue_from(Faraday::ServerError) do |exception|
    puts "Error ##{exception.response[:status]}"
  end

  def perform(params = {})
    r_body = {
      name: "#{params[:first_name]} #{params[:last_name]}",
      gender: 'male',
      email: params[:email],
      status: 'active'
    }

    req = Faraday.new do |f|
      f.response :raise_error
    end

    response = req.post('https://gorest.co.in/public/v1/users') do |r|
      r.params['access-token'] = '0375f841de50953f36828fd3b5d1baaacf7f7b1e788dc99cd57ea747731d39bb'
      r.headers['Content-Type'] = 'application/json'
      r.body = r_body.to_json
    end

    puts "status #{response.status}"
    puts JSON.parse(response.body)
  end
end
