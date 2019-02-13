class Article < ActiveRecord::Base
  has_many :user_articles
  has_many :users, through: :user_articles

  serialize :search_query


  def print
    system('clear')
    puts "\tTitle: #{self.headline}\n" unless self.headline.nil?
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


def save_article
  puts "What title would you like to give this article"
  title = gets.chomp
  self.users_title = title
  self.users << CLI.active_user
  self.save

end


  def self.show_all_favourited
    Article.all.map do |article|
      puts article.title
    end
  end

end
