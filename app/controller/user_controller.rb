module UserControls

  # hook method which automatically includes methods
  # defined in ClasseMethods when the parent Module is
  # included in the User class
  # .included : (self) -> extend UserControls::ClassMethods
  def self.included(base)
    base.extend(ClassMethods)
  end

  # class Methods for User class
  # Note: self in self.class_method_name is omitted
  # due to conflict. Despite no reference to self in
  # method definition, they are class methods.
  module ClassMethods
    # .login : -> nil
    def login
      message = "Welcome!"
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

    # Checks Users for any user with given name
    # .check_login : (String) -> Boolean
    def user_exists(name)
      self.all.any?{|user| user.name == name}
    end

    # If user exists, set as current_user and advance to user screen
    # If user does not exist, give option to create or send back to main screen
    # .login_user : -> nil
    def login_user
      puts "Please enter your name"
      name = CLI.gets_with_quit

      if self.user_exists(name)
        user = self.find_user(name)
        if check_password(user)
          CLI.active_user = user
        else
          CLI.start
        end

        # fall through to CLI.start
      else
        puts "Sorry it does not appear we have a user with that name"
        if CLI.yes_no("Would you like to sign up")
          self.signup_user(name)
        else
          CLI.start
        end
      end
    end

    def check_password(user)
      counter = 0
      while counter < 3
        password = PROMPT.mask("Enter your password")

        if user.password == password
          return true
        else
          puts "Wrong password please try again"
          puts "You have #{2 - counter} chance(s) left before you will be sent to the welcome page."
          counter +=1
        end
      end
      return false
    end




    # Create new User if username does not exist
    # .signup_user : (String) -> nil
    def signup_user(name=nil)
      if name.nil?
        puts "Please enter your name to signup"
        name = CLI.gets_with_quit

      end
      if self.user_exists(name)
        message =  "Sorry that name is already taken :("
        options = [ "Go To Login", "Try Again", "Back to Main Menu"]
        choice = PROMPT.select(message, options)
        case options.index(choice)
          when 0 then self.login_user
          when 1 then self.signup_user
          when 2 then CLI.start
        end
      else

        password = PROMPT.mask("Enter your password")
        user = User.create(name: name, password: password)

        CLI.active_user = user

      end
    end
  end #end of class modules

  # Lists articles favorited by current User
  # #list_favorited_articles : -> nil
  def list_favorited_articles
    CLI.active_user.reload
    message = "Which article would you like to open"
    articles = self.articles
    if articles.empty?
      self.no_articles
    else
      self.list_articles(articles, message)
    end
  end

  # Lists articles which haven't been favorited by current User
  # #list_not_favorited_articles : -> nil
  def list_not_favorited_articles
    CLI.active_user.reload
    users_articles = CLI.active_user.articles.map{|article| article.id}
    all_articles = Article.all.map{|article| article.id}
    uniq = all_articles - users_articles
    if uniq.empty?
      self.no_articles
    else
      articles = Article.all.select{|article| uniq.include?(article.id)}
      message = "Which article would you like to open"
      self.list_articles(articles, message )
    end
  end

  # Given array of articles and a message, displays articles
  # and allows one to be selected, or the User to return to the main
  # menu.
  # #list_articles([Article: instances], String) -> nil
  def list_articles(articles, message)
    options = articles.map{|article| article.users_title}
    back = "Back to Main Menu"
    options << back
    choice = PROMPT.select(message, options)
    if choice == back
      CLI.user_options
    else
      articles[options.index(choice)].article_options
    end
  end

  # Method to handle event of there being no articles
  # Allows user to Search or Return to Menu
  # #no_articles -> nil
  def no_articles
    message =  "Sorry, there are no results!"
    options = ["Go to Search", "Go Back"]
    choice = PROMPT.select(message, options)
    case options.index(choice)
      when 0
        Search.new_search
      when 1
        CLI.user_options
    end
  end
end
