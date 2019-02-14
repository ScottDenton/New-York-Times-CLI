class Article < ActiveRecord::Base
  has_many :user_articles
  has_many :users, through: :user_articles
  serialize :search_query

  def print
    puts ""
    puts "Title: #{self.users_title}"
    puts "Headline: #{self.headline}\n" unless self.headline.nil?
    puts ""
    puts "Summary: #{self.snippet}" unless self.snippet.nil?
    puts "Source : #{self.source}" unless self.source.nil?
    puts ""
    puts "Credit: #{self.credit}" unless self.credit.nil?
    puts ""
  end

  def open
    Launchy.open(self.url)
  end

  def self.parse(article)
    new_article = self.new()
    new_article.url ||= article['web_url']
    new_article.snippet ||= article['lead_paragraph']
    new_article.source ||= article['source']
    new_article.headline ||= article['headline']['main']
    if article['multimedia'] && article['multimedia'][1]
      new_article.credit ||= article['multimedia'][1]['credit']
    end
    new_article
  end

  def display_article

  end

  def article_options
    self.print
    list_message = "What would you like to do to your article?"
    options = ["Open", "rename", "(Un)favourite", "Back to menu"]
    choice = PROMPT.select(list_message, options)
    case options.index(choice)
    when 0
       self.open
     when 1
       self.name_article
     when 2
        if CLI.active_user.articles.include?(self)
          self.delete
        else
          self.save_article
        end
     when 3
       CLI.user_options
    end
     CLI.user_options
   end



  def name_article
    puts "What title would you like to give this article"
    title = gets.chomp
    self.users_title = title
    self.save

  end

  def save_article
    self.name_article
    self.users << CLI.active_user
    self.save
  end


  def self.show_all_favourited
    Article.all.map do |article|
      puts article.title
    end
  end


  end# end of class
