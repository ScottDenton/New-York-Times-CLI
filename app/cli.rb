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
    self.start
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
    self.start
  end

  def self.list_articles(articles)
    # self.new_page
    # binding.pry
    for article in articles
      parsed_article = Article.parse(article)
      parsed_article.print
      # binding.pry
      parsed_article.open if self.yes_no("Open Article")
      parsed_article.save_article if self.yes_no("Save Article")
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
end #end of CLI class
