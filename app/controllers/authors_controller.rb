require 'net/http'
require 'json'
require 'uri'

class AuthorsController < ActionController::Base
  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    uri = URI.parse('https://www.boredapi.com/api/activity') # simple API returning some random activity
    if @author.valid?
      Thread.new do
        #  GET Request

        result = Net::HTTP.get(uri)
        puts JSON.parse(result)['activity']
        #  POST Request

        # http = Net::HTTP.new(URL)
        # header = {'Content-Type': 'text/json'}
        # req = Net.HTTP::Post.new(uri.request_uri, header)
        # req.body = JSON.generate({
        #   firstName: @author.first_name,
        #   lastName: @author.last_name,
        #   email: @author.email
        # })
        # response = http.request(req)
        # puts response
      end
    end
  end

  def author_params
    params.require(:author).permit(:first_name, :last_name, :email)
  end
end
