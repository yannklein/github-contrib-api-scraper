require 'sinatra'
require "sinatra/json"
require 'sinatra/reloader'
require 'json'
require 'open-uri'
require 'date'
require 'pry'

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
