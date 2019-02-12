require_relative '../config/environment'
require_relative '../config/.keys'
require 'pry'
require 'launchy'



search = CLI::Search.search_loop



unless search[:start].nil?
  date_query = "&facet_field=day_of_week&facet=true&begin_date=#{search[:start_date]}&end_date=#{search[:end_date]}"
end
# binding.pry

  string = RestClient.get("https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{search[:subject]}&api-key=#{NYT_KEY}#{date_query}")

  hash = JSON.parse(string)

  article = hash["response"]['docs'].first
binding.pry
   puts 'Snippet: ' + article['snippet']
   puts 'URL: ' + article['web_url']
   puts''
   puts 'Enter "open" if you would like to open the article in your browser or "save" to save this search to your profile'
   open = gets.chomp.downcase
   if open == 'open'
    Launchy.open(article['web_url'])
  elsif open == "save"
    puts "This article has been saved to your profile"
  else
    puts "goodbye"
  end
