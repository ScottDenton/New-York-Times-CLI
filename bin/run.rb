require_relative '../config/environment'
require_relative '../config/.keys'
require 'pry'
require 'launchy'



search = CLI::Search.search_loop



unless search[:start].nil?
  date_query = "&facet_field=day_of_week&facet=true&begin_date=#{search[:start]}&end_date=#{search[:end]}"
end
# binding.pry

  string = RestClient.get("https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{search[:subject]}&api-key=#{NYT_KEY}#{date_query}")

  hash = JSON.parse(string)

  article = hash["response"]['docs'].first
   puts '.1 ' + article['snippet']
   puts '.2 ' + article['web_url']
