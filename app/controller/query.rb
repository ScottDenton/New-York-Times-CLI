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
                      "&facet_field=day_of_week&facet=true&begin_date=#{start_date}&end_date=#{end_date}"
    headline_query =  headline.nil? ? "" : "&fq=headline:(#{headline})"

    subject_query + keyword_query + category_query + headline_query + date_query
  end

  def self.request(query)
    base = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q="
    request = "#{base}#{query}&api-key=#{NYT_KEY}"

    begin
      RestClient::Request.execute(:method => :get, :url => request, :timeout => 5, :open_timeout => 5)
    rescue => e

      if e.class == RestClient::BadRequest
        message = 'Your search request was invalid. Please try again.'
      elsif e.class == SocketError
        message = "There appears to be a problem with your connection"
      else
        binding.pry
      end

      options = ["Try again", "Exit to menu"]
      choice = PROMPT.select(message, options)

      case options.index(choice)
        when 0 then Search.new_search
        when 1 then CLI.user_options
      end
    end
  end

  def self.parse(json)
    JSON.parse(json)
  end
end