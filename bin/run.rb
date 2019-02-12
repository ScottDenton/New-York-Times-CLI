require_relative '../config/environment'
require_relative '../config/.keys'
require 'pry'
require 'launchy'



subject = CLI::Search.subject
date = CLI::Search.date
unless date.nil?
  date_query = "&facet_field=day_of_week&facet=true&begin_date=#{date}"
end 

  string = RestClient.get("https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{subject}&api-key=#{NYT_KEY}#{date_query}")
  hash = JSON.parse(string)

  article = hash["response"]['docs'].first
   puts '.1 ' + article['snippet']
   puts '.2 ' + article['web_url']








  # puts hash['title']
  # link =  hash['img']
  # puts hash['alt']
  # puts 'type " open" to open a link to the image'
  # response = gets.chomp
  # if response = 'open'
  #   Launchy.open(link)
  # else
  #   return
  # end
