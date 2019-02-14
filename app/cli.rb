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
    User.login_signup
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

  def self.search
    View.new_page

    search = Search.build_search
    query = Query.build_query(search)
    json = Query.request(query)
    parsed = Query.parse(json)
    articles = parsed["response"]["docs"]

    self.list_articles(articles)
    self.user_options
  end

  def self.list_articles(articles)
    for article in articles
      parsed_article = Article.parse(article)
      parsed_article.print
      parsed_article.open if self.yes_no("Open Article")
      parsed_article.save_article if self.yes_no("Favorite Article")

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

  def self.user_options
    CLI.active_user.reload
    View.new_page

    message = "What would you like to do."
    options = ["Search","Favourited Articles", "Other Articles", "Logout"]
    choice = PROMPT.select(message,options)

    case options.index(choice)
      when 0 then self.search
      when 1
        self.active_user.list
        case options.index(choice)
          when 0
            self.search
          when 1
            self.user_options
          end
      when 2
        self.active_user.all_other_articles
      when 3 then self.intro # switch users
    end
    self.user_options
  end

end #end of CLI class
