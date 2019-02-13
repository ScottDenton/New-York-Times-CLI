class CLI

@@active_user = nil

  def self.main_loop
  end


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

  def self.help
  end

  def self.list_topics
    topics = ["Adventure Sports", "Arts & Leisure", "Arts", "Automobiles",
              "Business", "Culture", "Editorial", "Entrepreneurs", "Environment",
              "Fashion & Style", "Financial", "Food", "Foreign", "Health & Fitness",
              "Home & Garden", "Movies", "Museums", "Politics", "Science", "Sports",
              "Technology", "Travel", "Weather", "World"]
    topics.each_with_index do |v, i|
    end
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

    puts "Welcome to the NYT CLI Search!"
    puts "Type 'quit' at any time to exit."

    search = Search.build_search
    query = Query.build_query(search)
    json = Query.request(query)
    parsed = Query.parse(json)
    articles = parsed["response"]["docs"]

    self.list_articles(articles)
    self.start
  end

  def self.list_articles(articles)
    for article in articles
      parsed_article = Article.parse(article)
      parsed_article.print

      parsed_article.open if self.yes_no("Open Article")
      parsed_article.save_article if self.yes_no("Save Article")
      binding.pry
      break if self.yes_no("Exit")
    end
  end




  def self.yes_no(message)
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
    puts "What would you like to do, please enter the corresponding number. "
    puts "1. Search for an article"
    puts "2. Search your favourited articles"
    puts "3. Search all but your favourited articles"
    option = gets.chomp
    case option
    when '1'
       self.start
     when '2'
       self.active_user.list_own_articles
     when '3'
       self.active_user.all_other_articles
     when 'exit' || 'quit'
       exit
     else
       puts "Sorry we did not recognise your input"
       self.options
     end
  end

end #end of CLI class
