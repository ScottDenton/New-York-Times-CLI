class Search

  def self.new_search
    View.new_page

    search = Search.search_criteria
    query = Query.build_query(search)
    json = Query.request(query)
    parsed = Query.parse(json)
    articles = parsed["response"]["docs"]

    Article.list_articles(articles)
    CLI.user_options
  end

  def self.search_criteria
    View.new_page
    search_hash = {}
    search_hash[:subject] = self.subject
    
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
            search_hash[:headline] =  self.headline_search
          when 1
            dates = self.date_search
            search_hash[:start_date] = dates[:start_date]
            search_hash[:end_date] = dates[:end_date]
          when 2
            search_hash[:category] = self.category_search
          when 3
            search_hash[:keyword] = self.keyword_search        
          when 4
            break
        end
      end
    end
    search_hash
  end #end of search class

  def self.subject
    View.new_page
    puts''
    print "Subject: "
    subject = CLI.gets_with_quit
  end

  def self.headline_search
    View.new_page
    puts''
    print 'Headline Contains: '
    headline = CLI.gets_with_quit
  end

  def self.date_search
    View.new_page
    options = ["Today", "Yesterday", "Past Week", "Date", "Date Range"]
    message =  "Search for:"
    choice = PROMPT.select(message, options)
    case options.index(choice)
    when 0
      start_date = end_date = Time.now.strftime("%Y%m%d")
    when 1
      start_date = end_date = (Time.now - (3600 * 24)).strftime("%Y%m%d")
    when 2
      start_date = Time.now.strftime("%Y%m%d")
      end_date = (Time.now - (3600 * 24 * 7)).strftime("%Y%m%d")
    when 3
      print "Date YYYYMMDD: "
      start_date = end_date = self.gets_validate_date
    when 4
      print "Start Date YYYYMMDD: "
      start_date = self.gets_validate_date
      puts ""
      print "End Date YYYYMMDD: "
      end_date = self.gets_validate_date
    end
    {start_date: start_date, end_date: end_date}
  end

  def self.category_search
    View.new_page
    message =  "What category would you like to search within?"
    options = ["Adventure Sports", "Arts & Leisure", "Arts", "Automobiles",
      "Business", "Culture", "Editorial", "Entrepreneurs", "Environment",
      "Fashion & Style", "Financial", "Food", "Foreign", "Health & Fitness",
      "Home & Garden", "Movies", "Museums", "Politics", "Science", "Sports",
      "Technology", "Travel", "Weather", "World"]
      choice = PROMPT.select(message, options)
  end
  
  def self.keyword_search
    View.new_page
    puts''
    print "Keyword(s): "
    keyword = CLI.gets_with_quit
  end
  
  def self.gets_validate_date
    string = CLI.gets_with_quit
    if string =~ /\A[12]\d{3}[01]\d[0-3]\d\z/
      return string
    else
      puts "Invalid Date Format: Use Year Month Day"
      print "Re-Enter Date YYYYMMDD: "
      return self.gets_validate_date
    end
  end
end