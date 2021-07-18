require 'faraday'

module Api
  URL = 'https://gorest.co.in/public/v1/users'.freeze
  AUTH_KEY = '0375f841de50953f36828fd3b5d1baaacf7f7b1e788dc99cd57ea747731d39bb'.freeze

  def self.send_data(data = {})
    r_body = {
      name: "#{data[:first_name]} #{data[:last_name]}",
      gender: 'male',
      email: data[:email],
      status: 'active'
    }

    req = Faraday.new do |f|
      f.response :raise_error
    end

    req.post(URL) do |r|
      r.params['access-token'] = AUTH_KEY
      r.headers['Content-Type'] = 'application/json'
      r.body = r_body.to_json
    end
  end
end
