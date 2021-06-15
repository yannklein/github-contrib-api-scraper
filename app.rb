require 'sinatra'
require "sinatra/json"
require 'sinatra/reloader'
require 'json'
require 'open-uri'
require 'date'
require 'pry'
require "sinatra/cors"
require 'nokogiri'

set :allow_origin, "http://localhost:8080 http://localhost:4567 https://www.yannklein.me https://yannklein.github.io"

get '/:github_account' do

  url = "https://github.com/#{params[:github_account]}";

  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)
  
  contrib_square_class = ".ContributionCalendar-day[data-date='#{Date.today.strftime('%Y-%m-%d')}']"

  today_contribution = html_doc
    .search('.js-calendar-graph-svg')
    .search(contrib_square_class)
    .attribute('data-count')
    .value

  contrib = {
    today_contrib: today_contribution,
    date: Date.today.strftime('%Y-%m-%d')
  }

  begin
    json contrib
  rescue OpenURI::HTTPError => e
    'Github account not existing. '
  end
end
