# Namespace wrapper for search methods
class Search

  # Wraps the search build and execute sequence
  # .new_search -> nil
  def self.new_search
    View.new_page   # clear page & display banner

    search = Search.search_criteria         # get user search criteria
    query = Query.build_query(search)       # build query from criteria
    json = Query.request(query)             # request from API
    parsed = Query.parse(json)              # parse returned request
    articles = parsed["response"]["docs"]   # extract articles from returned JSON
    if articles.empty?                        # if no articles allow user to choose
      self.no_results                         # desired path
    else
      Article.list_articles(articles)       # if articles, display articles and allow
    end                                     # user to open, favourite, view next
    CLI.user_options                        # or return to main screen
  end

  # Requests User input and saves to hash to be turned into
  # API query
  # .search_criteria : -> {subject: String, headline: String,
  #                        start_date: String, end_date: String,
  #                        category: String, keyword: String}
  def self.search_criteria
    View.new_page
    search_hash = {}
    search_hash[:subject] = self.get_input_new_page("Search For")

    while true
      puts''
      unless CLI.yes_no("Refine Search")
        break
      else
        message = "Refine By:"
        options = ["Headline", "Date", "Category", "Keyword", "Continue to Search"]
        choice = PROMPT.select(message, options)
        case options.index(choice)
          when 0
            search_hash[:headline] =  self.get_input_new_page("Headline")
          when 1
            dates = self.date_search
            search_hash[:start_date] = dates[:start_date]
            search_hash[:end_date] = dates[:end_date]
          when 2
            category = self.category_search
            search_hash[:category] = category unless category == "None"
          when 3
            search_hash[:keyword] = self.get_input_new_page("Keyword")
          when 4
            break
        end
      end
    end
    search_hash
  end #end of search class

  # Displays message and returns input
  # with passthrough processing for global quit
  # .get_input_new_page : (String) -> String
  def self.get_input_new_page(message)
    View.new_page
    puts''
    print "#{message}: "
    CLI.gets_with_quit
  end

  # Gives user options to select dates or enter custom dates
  # Ensures dates fit valid format
  # .date_search : -> {start_date: String, end_date: String}
  def self.date_search
    View.new_page
    options = ["Today", "Yesterday", "Past Week", "Date", "Date Range"]
    message =  "Search for:"
    choice = PROMPT.select(message, options)

    case options.index(choice)
      when 0 # today
        start_date = end_date = Time.now.strftime("%Y%m%d")
      when 1 # yesterday
        start_date = end_date = (Time.now - (3600 * 24)).strftime("%Y%m%d")
      when 2 # last seven days
        start_date = (Time.now - (3600 * 24 * 7)).strftime("%Y%m%d")
        end_date = Time.now.strftime("%Y%m%d")
      when 3 # specific date
        start_date = end_date = self.gets_validate_date("Date")
      when 4 # date range
        start_date = self.gets_validate_date("Start Date")
        puts ""
        end_date = self.gets_validate_date("End Date")
        # if start_date is later than end_date, causees a query error
        # detect and swtich values
        if start_date.to_i > end_date.to_i
          tmp = end_date
          end_date = start_date
          start_date = tmp
        end
    end
    {start_date: start_date, end_date: end_date}
  end

  # Displays selection list of available categories
  # Allows user to select from list then returns selection
  # .category_search : -> String
  def self.category_search
    View.new_page
    message =  "What category would you like to search within?"
    options = ["None", "Adventure Sports", "Arts & Leisure", "Arts", "Automobiles",
      "Business", "Culture", "Editorial", "Entrepreneurs", "Environment",
      "Fashion & Style", "Financial", "Food", "Foreign", "Health & Fitness",
      "Home & Garden", "Movies", "Museums", "Politics", "Science", "Sports",
      "Technology", "Travel", "Weather", "World"]
      choice = PROMPT.select(message, options)
  end

  # Validates date is correct YYYYMMDD format
  # if not, reprompts use for correct date
  # returns validated date string
  # .gets_validate_date : (String) -> String
  def self.gets_validate_date(message)
    print "#{message} YYYYMMDD: "
    string = CLI.gets_with_quit
    if string =~ /\A[12]\d{3}[01]\d[0-3]\d\z/
      return string
    else
      puts "Invalid Date Format: Use Year Month Day"
      print "Re-Enter Date YYYYMMDD: "
      return self.gets_validate_date(message)
    end
  end

  # Handles event of there being no articles found
  # after successful search. Provides user with
  # choice to search again or return to main menu.
  # .no_results -> nil
  def self.no_results
    message = "Sorry, No Articles Were Found"
    options = ["New Search", "Main Menu"]
    choice = PROMPT.select(message, options)
    case options.index(choice)
      when 0 then Search.new_search
      when 1 then CLI.user_options
    end
  end

end
