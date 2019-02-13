class CLI

@@active_user = nil

  def self.banner
    system("clear")
    <<-BANNER

          #     #                  #     #
          ##    # ###### #    #     #   #   ####  #####  #    #
          # #   # #      #    #      # #   #    # #    # #   #
          #  #  # #####  #    #       #    #    # #    # ####
          #   # # #      # ## #       #    #    # #####  #  #
          #    ## #      ##  ##       #    #    # #   #  #   #
          #     # ###### #    #       #     ####  #    # #    #

                     #######
                        #    # #    # ######  ####
                        #    # ##  ## #      #
                        #    # # ## # #####   ####
                        #    # #    # #           #
                        #    # #    # #      #    #
                        #    # #    # ######  ####

    BANNER
  end

  def self.new_page
    puts self.banner
    puts ""
  end

  def self.header
    puts "Welcome to the NYT CLI Search!"
    puts "Type 'quit' at any time to exit."
  end

  def self.active_user=(user)
    @@active_user = user
  end

  def self.active_user
    @@active_user
  end

  def self.login_signup
    if self.yes_no("Are you already a member")
      User.login
    else
      User.signup_user
    end
  end


  def self.intro
    puts self.banner
    self.header
    self.login_signup
    self.options
    # self.start
  end

  def self.gets_with_quit
    response = gets.chomp.downcase
    if response == "quit"
      exit
    else
      response
    end
  end

  def self.start
    self.new_page
    search = Search.build_search
    query = Query.build_query(search)
    json = Query.request(query)
    parsed = Query.parse(json)
    articles = parsed["response"]["docs"]

    self.list_articles(articles)
    self.options
  end

  def self.list_articles(articles)
    for article in articles
      parsed_article = Article.parse(article)
      parsed_article.print
      parsed_article.open if self.yes_no("Open Article")
      parsed_article.save_article if self.yes_no("favourited Article")

      break if self.yes_no("Exit")
    end
  end

  def self.yes_no(message)
    # self.new_page
    puts "#{message} (y/n)?"
    response = CLI.gets_with_quit
    if response =~ /y|yes/
      true
    elsif response =~ /n|no|^.{0}$/
      false
    else
      puts "Sorry, we didn't get that!\n"
      return yes_no(message)
    end
  end

  def self.options
    self.new_page
    message = "What would you like to do. "
    options = ["Search","Favourited articles", "Other articles"]
    choice = PROMPT.select(message,options)
    case options.index(choice)
    when 0
       self.start
     when 1
        self.active_user.list unless self.active_user.articles.empty?
        message =  "Sorry there are currently no saved articles. Have a search to find some new ones"
        options = ["Go to search", "Go back"]
        choice = PROMPT.select(message, options)
        case options.index(choice)
        when 0
          self.start
        when 1
          self.options
        end 
     when 2
       self.active_user.all_other_articles
     when 'exit' || 'quit'
       exit
     else
       puts "Sorry we did not recognise your input"
       self.options
     end
     self.options
  end

end #end of CLI class
