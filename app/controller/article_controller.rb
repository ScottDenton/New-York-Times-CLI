module ArticleControls

  # hook method which automatically includes methods
  # defined in ClasseMethods when the parent Module is
  # included in the Article class
  # .included : (self) -> extend ArticleControls::ClassMethods
  def self.included(base)
    base.extend(ClassMethods)
  end

  # class Methods for Article class
  # Note: self in self.class_method_name is omitted
  # due to conflict. Despite no reference to self in
  # method definition, they are class methods.
  module ClassMethods

    # Given an Article instance, User can choose to 
    # Open the Article URL, Add Article to Favourites
    # Advance to the next Article in a list of articles
    # Or return to the Main Menu
    # .show_article_options : (Article: instance) -> nil
    def show_article_options(article)
      message = "What would you like to do with this article ?"
      options = ["Open", "Favourite", "Next article", "Back to Menu"]
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

    # Given an Array of Article instances, instantiates
    # displays each Article instance's available info
    # then gives User opportunity to interact with Article
    # .list_articles : ([Article: instances]) -> nil
    def list_articles(articles)
      for article in articles
        parsed_article = Article.parse(article)
        parsed_article.print

        self.show_article_options(parsed_article)
      end
    end
  end # End of Class Methods

# Displays attributes of self: Article instance
# Not all attributes are always available, so we must check for
# existence before printing
# #print : -> nil
def print
  system("clear")
  puts ""
  puts "Title:    ".green.bold + self.users_title  unless self.users_title.nil?
  puts "Headline: ".green.bold + self.headline     unless self.headline.nil?
  puts ""
  puts "Summary:  ".green.bold + self.snippet      unless self.snippet.nil?
  puts "Source:   ".green.bold + self.source       unless self.source.nil?
  puts ""
  puts "Credit:   ".green.bold + self.credit       unless self.credit.nil?
  puts ""
end

# opens self.url in browser
# #open : -> Process: instance
def open
  Launchy.open(self.url)
end

# Presents User with options to interact with Article instance
# Checks if user has already favorited article and if not
# allows them to, otherwise removes article reference (entirely...)
# #article_options : -> nil
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
      self.article_options
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

  # Prompts User for name of article and saves
  # #name_article : -> Article: instance
  def name_article
    puts "What title would you like to give this article"
    title = gets.chomp
    self.users_title = title
    self.save
  end
end #end of all modules
