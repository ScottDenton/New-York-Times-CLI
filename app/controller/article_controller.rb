module ArticleControls
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def show_all_favourited
      Article.all.map do |article|
        puts article.title
      end
    end

    def show_article_options(article)
      message = "What would you like to do with this article ?"
      options = ["Open", "favourite", "Next article", "Back to menu"]
      choice = PROMPT.select(message, options)
      case options.index(choice)
      when 0
         article.open
         show_article_options(article)
       when 1
         article.save_article
       when 2
        # falls through to next article
       when 3
         CLI.user_options
      end
    end

    def list_articles(articles)
      for article in articles
        parsed_article = Article.parse(article)
        parsed_article.print
        self.show_article_options(parsed_article)
      end
    end
  end


def print
  system("clear")
  puts ""
  puts "Title:".green.bold +  " #{self.users_title}" unless self.users_title.nil?
  puts "Headline:".green.bold +  " #{self.headline}\n" unless self.headline.nil?
  puts ""
  puts "Summary:".green.bold +  " #{self.snippet}" unless self.snippet.nil?
  puts "Source : ".green.bold +  "#{self.source}" unless self.source.nil?
  puts ""
  puts "Credit:".green.bold +  " #{self.credit}" unless self.credit.nil?
  puts ""
end

def open
  Launchy.open(self.url)
end

def article_options
  if CLI.active_user.articles.include?(self)
    options = ["Open", "Unfavourite", "Back to menu"]
  else
    options = ["Open", "Favourite", "Back to menu"]
  end
  self.print
  list_message = "What would you like to do to your article?"

  choice = PROMPT.select(list_message, options)
  case options.index(choice)
  when 0
      self.open
    when 1
      if CLI.active_user.articles.include?(self)
        self.delete
      else
        self.favourite_article
      end
    when 2
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
end #end of all modules
