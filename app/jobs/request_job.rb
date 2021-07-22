require 'faraday'
require_relative '../api/api'

class RequestJob < ApplicationJob
  queue_as :default
  retry_on Faraday::TimeoutError

  rescue_from(Faraday::ClientError) do |e|
    data = JSON.parse(e.response[:body])['data'][0]
    puts ''
    puts "Error ##{e.response[:status]}. #{data['field']} #{data['message']}"
    puts ''
  end

  rescue_from(Faraday::ServerError) do |e|
    puts ''
    puts "Error ##{e.response[:status]}. #{data['field']} #{data['message']}"
    puts ''
  end

  def perform(params = {})
    Api.send_data(params)
  end
end
