class User < ActiveRecord::Base
  has_many :user_articles
  has_many :articles, through: :user_articles

  def list_own_articles
    CLI.active_user.articles.map do |article|
      system('clear')
      puts ''
      puts "Your title: " + article.users_title
      puts "Headline: " + article.headline
      puts ''
      puts article.snippet
      puts ''
      article.open if CLI.yes_no("Open Article")

      article.delete if CLI.yes_no("Un-Favourite this Article")

    end
    puts "That was the last of your articles"
    puts ''
    CLI.options
  end

  def find_article

  end

  def all_other_articles
    users_articles = CLI.active_user.articles.map{|article| article.id}
    all_articles = Article.all.map{|article| article.id}
    answer = users_articles + all_articles
    uniq = answer - (users_articles & all_articles)
     Article.all.select{|article| uniq.include?(article.id)}
  end

  def self.find_user(name)
    self.all.find{|user| user.name == name}
  end

  def self.check_login(name)
    self.all.any?{|user| user.name == name}
  end

  def self.signup_user
    puts "Please enter your name to signup"
    name = CLI.gets_with_quit
    if self.check_login(name)
      puts "Sorry that name is already taken :("
      self.signup_user
    else
      user =  User.create(name: name)
      CLI.active_user = user
    end
  end

  def self.login
    puts "Please enter your name"
    name = CLI.gets_with_quit
    user = self.find_user(name)
    CLI.active_user = user
  end

end
