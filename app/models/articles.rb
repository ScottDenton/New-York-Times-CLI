class Article < ActiveRecord::Base
  has_many :users, through: :user_articles
  serialize :search_query


  def print
    system('clear')
    puts "\t \t \t Title: " + self.headline unless self.headline.nil?
    puts self.snippet unless self.snippet.nil?
    puts 'Source : ' + self.source unless self.source.nil?
    puts 'Credit: ' + self.credit unless self.credit.nil?
    puts ''
  end

  def open
     Launchy.open(self.url)
  end

  def self.parse(article)
    new_article = self.new()
    new_article.url ||= article['web_url']
    new_article.snippet ||= article['snippet']
    new_article.source ||= article['source']
    new_article.headline ||= article['headline']['main']
    if article['multimedia'] && article['multimedia'][1]
      new_article.credit ||= article['multimedia'][1]['credit']
    end
    new_article
  end

end
