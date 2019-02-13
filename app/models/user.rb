class User < ActiveRecord::Base
  has_many :user_articles
  has_many :articles, through: :user_articles

  def list_own_articles
    CLI.active_user.reload
    CLI.active_user.articles.map do |article|
      article.print
      article.open if CLI.yes_no("Open Article")
      article.delete if CLI.yes_no("Un-Favourite this Article")
    end
    CLI.options
  end

  def list
    CLI.active_user.reload
    message = "Which article would you like to open"
    articles = self.articles
    self.list_articles(articles, message)
    # options = articles.map{|article| article.users_title}
    # choice = PROMPT.select(list_message, options)
    # articles[options.index(choice)].article_options
  end

  def list_articles(articles, message)
    options = articles.map{|article| article.users_title}
    choice = PROMPT.select(message, options)
    articles[options.index(choice)].article_options
  end



  def all_other_articles
    CLI.active_user.reload
    users_articles = CLI.active_user.articles.map{|article| article.id}

    all_articles = Article.all.map{|article| article.id}

    uniq = all_articles - users_articles

    articles = Article.all.select{|article| uniq.include?(article.id)}
    message = "Which article would you like to open"
    list_articles(articles, message )
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
