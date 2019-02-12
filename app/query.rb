require_relative '../config/environment'
require_relative '../config/.keys'
require 'pry'
require 'json'

class Query

  def self.build_query( subject: nil, 
                        keyword: nil, 
                        category: nil, 
                        start_date: nil, 
                        end_date: nil, 
                        headline: nil)
    
    subject_query =   subject.nil? ? "" : subject
    keyword_query =   keyword.nil? ? "" : "&#{keyword}"
    category_query =  category.nil? ? "" : "&fq=news_desk:(#{category})"
    date_query =      start_date.nil? || end_date.nil? ? "" : 
                      "&facet_field=day_of_week&facet=true&begin_date=#{start_date}&end_date#{end_date}"
    headline_query =  headline.nil? ? "" : "&fq=headline:(#{headline})"
    
    subject_query + keyword_query + category_query + headline_query + date_query
  end

  def self.request(query)
    base = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q="
    request = "#{base}#{query}&api-key=#{NYT_KEY}"
    # binding.pry
    RestClient.get(request)
  end

  def self.parse(json)
    JSON.parse(json)
  end
end

query = Query.build_query(subject: "sport", start_date: 20020101, end_date: 20020101)
json = Query.request(query)
parsed = Query.parse(json)
articles = parsed["response"]["docs"]
puts JSON.pretty_generate articles.first

# unless search[:start].nil?
#   date_query = "&facet_field=day_of_week&facet=true&begin_date=#{search[:start]}&end_date=#{search[:end]}"
# end
# # binding.pry

#   string = RestClient.get("https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{search[:subject]}&api-key=#{NYT_KEY}#{date_query}")

#   hash = JSON.parse(string)

#   article = hash["response"]['docs'].first
#    puts '.1 ' + article['snippet']
#    puts '.2 ' + article['web_url']
