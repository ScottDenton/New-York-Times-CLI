module UsersModule
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # def self.login_signup
    #   if CLI.yes_no("Are you already a member")
    #     self.login
    #   else
    #     self.signup_user
    #   end
    # end

    def login
      message = "Welcome"
      options = ["Login", "Sign up", "Exit"]
      choice = PROMPT.select(message, options)
      case options.index(choice)
      when 0
         self.login_user
       when 1
         self.signup_user
       when 2
         exit
       end
    end

    def check_login(name)
      self.all.any?{|user| user.name == name}
    end

    def login_user
      puts "Please enter your name"
      name = CLI.gets_with_quit
      if self.check_login(name)
        user = self.find_user(name)
        CLI.active_user = user
      else
        puts "Sorry it does not appear we have a member with that name"
        if CLI.yes_no("Would you like to sign up")
          self.signup_user(name)
        else
          CLI.intro
        end
      end

    end

    def signup_user(name=nil)
      if name.nil?
      puts "Please enter your name to signup"
      name = CLI.gets_with_quit
    end
      if self.check_login(name)
        puts "Sorry that name is already taken :("
        self.signup_user
      else
        user =  User.create(name: name)
        CLI.active_user = user
      end
    end

  end #end of class modules

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
    if articles.empty?
      self.list_empty
    else
      self.list_articles(articles, message)
    end
  end

  def list_articles(articles, message)
    options = articles.map{|article| article.users_title}
    choice = PROMPT.select(message, options)
    articles[options.index(choice)].article_options
  end

  def list_empty
    message =  "Sorry, there are no results!"
    options = ["Go to Search", "Go Back"]
    choice = PROMPT.select(message, options)
    case options.index(choice)
      when 0
        CLI.search
      when 1
        CLI.user_options
    end
  end

  def all_other_articles
    CLI.active_user.reload
    # binding.pry
    users_articles = CLI.active_user.articles.map{|article| article.id}
    all_articles = Article.all.map{|article| article.id}
    uniq = all_articles - users_articles
    if uniq.empty?
      self.list_empty
    else
      articles = Article.all.select{|article| uniq.include?(article.id)}
      message = "Which article would you like to open"
      self.list_articles(articles, message )
    end
  end






end
