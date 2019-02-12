require_relative '../config/environment'
require_relative '../config/.keys'
require 'pry'
# require 'launchy'



# search = CLI::Search.search_loop
# query = Query.build_query(search)
# json = Query.request(query)
# parsed = Query.parse(json)
# articles = parsed["response"]["docs"]
# puts JSON.pretty_generate articles.first

# subject: "baseball, "
# category: "Sports"
# start_date: 20020101, end_date: 20020101)
query = Query.build_query(subject: "Washington", category: "Politics", start_date: 20110101, end_date: 20130101)
json = Query.request(query)
parsed = Query.parse(json)
articles = parsed["response"]["docs"]
articles.each {|article| puts article["snippet"]}
 articles.first["snippet"] #JSON.pretty_generate