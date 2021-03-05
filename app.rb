require 'sinatra'
require "sinatra/json"
require 'sinatra/reloader'
require 'json'
require 'open-uri'
require 'date'
require 'pry'
require "sinatra/cors"

set :allow_origin, "http://localhost:8080 http://localhost:4567 https://www.yannklein.me https://yannklein.github.io"

api_url = "https://github-contributions.now.sh/api/v1/"
nested_query = "?format=nested"

get '/:github_account' do
  endpoint = "#{api_url}#{params[:github_account]}?format=#{params[:format]}"
  begin
    json JSON.parse(URI.open(endpoint).read)
  rescue OpenURI::HTTPError => e
    'Github account not existing. '
  end
end
