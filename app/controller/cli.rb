class CLI

  @@active_user = nil

  # Setter for class variable holding active user instance
  # .active_user : (User: instance) -> User: instance
  def self.active_user=(user)
    @@active_user = user
  end

  # Getter for class variable holding active user instance
  # .active_user : -> User: instance
  def self.active_user
    @@active_user
  end

  # Landing Page when CLI initializes
  def self.start
    View.banner       # Display Banner
    User.login        # Login Screen -> Enter Username or Create New User
    self.user_options # Choose to Move to Search, Favorites, Other Articles, or Logout
  end

  # Displays User Choices
  def self.user_options
    CLI.active_user.reload  # Ensure User's articles list is fresh from DB
    View.new_page

    message = "What would you like to do."
    options = ["Search","Favourited Articles", "Other Articles", "Logout"]
    choice = PROMPT.select(message,options)

    case options.index(choice)
      when 0 then Search.new_search
      when 1 then self.active_user.list_favorited_articles
      when 2 then self.active_user.list_not_favorited_articles
      when 3 then self.start # switch users
    end
    self.user_options
  end

  # Implements global exit for text input
  # .gets_with_quit : -> String || exit CLI
  def self.gets_with_quit
    response = gets.chomp.downcase
    if response == "quit"
      exit
    else
      response
    end
  end

  # Helper Method for Interface Re-use
  # Multi-select option for yes/no choice
  # .yes_no : (String) -> Boolean
  def self.yes_no(message)
    options = ["Yes", "No"]
    choice = PROMPT.select(message, options)
    case options.index(choice)
      when 0 then true
      when 1 then false
    end
  end
end #end of CLI class
