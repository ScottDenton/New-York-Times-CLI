require_relative '../config/environment'
require_relative '../config/.keys'
require 'pry'
require 'launchy'


search = CLI::Search.search_loop
# query = Query.build_query(search)
# json = Query.request(query)
# parsed = Query.parse(json)
# articles = parsed["response"]["docs"]
# puts JSON.pretty_generate articles.first

# subject: "baseball, "
# category: "Sports"
# start_date: 20020101, end_date: 20020101)
query = Query.build_query(search)
json = Query.request(query)
parsed = Query.parse(json)
articles = parsed["response"]["docs"]

articles.each do |article|
  parsed_article = Article.parse(article)
  # binding.pry
  parsed_article.print

  puts 'Open Article (y/n)?'
  open = gets.chomp.downcase
  if open == 'y'
    parsed_article.open
  end

  puts 'Save Article (y/n)?'
  save = gets.chomp.downcase
  if save == 'y'
    parsed_article.save
  end
end

 # articles.first["snippet"] #JSON.pretty_generate
 #
 # puts 'Enter "open" if you would like to open the article in your browser or "save" to save this search to your profile'
 #   open = gets.chomp.downcase
 #   if open == 'open'
 #    Launchy.open(articles['web_url'])
 #  elsif open == "save"
 #    puts "This article has been saved to your profile"
 #  else
 #    puts "goodbye"
 #  end
