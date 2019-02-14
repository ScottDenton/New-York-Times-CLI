class CLI

  @@active_user = nil

  def self.active_user=(user)
    @@active_user = user
  end

  def self.active_user
    @@active_user
  end

  def self.intro
    View.banner
    View.header
    User.login
    self.user_options
  end

  def self.user_options
    CLI.active_user.reload
    View.new_page

    message = "What would you like to do."
    options = ["Search","Favourited Articles", "Other Articles", "Logout"]
    choice = PROMPT.select(message,options)

    case options.index(choice)
      when 0 then Search.new_search
      when 1 then self.active_user.list
        # case options.index(choice)
        #   when 0 then Search.new_search
        #   when 1 then self.user_options
        # end
      when 2 then self.active_user.all_other_articles
      when 3 then self.intro # switch users
    end
    self.user_options
  end

  def self.gets_with_quit
    response = gets.chomp.downcase
    if response == "quit"
      exit
    else
      response
    end
  end

  def self.yes_no(message)
    options = ["Yes", "No"]
    choice = PROMPT.select(message, options)
    case options.index(choice)
    when 0 then true
    when 1 then false
    end
  end
end #end of CLI class
