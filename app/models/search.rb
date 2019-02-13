class Search
  def self.build_search
    search_hash = {}
    search_hash[:subject] = self.subject
    while true
      puts''
      unless CLI.yes_no("Would you like to refine your search")
        break
      else
        puts "\nWhat criteria would you like to add?"
        puts "Headline - Date - Keyword"
        criteria = gets.chomp.downcase

        case criteria
          when 'headline'
          search_hash[:headline] =  self.headline_search
          when 'date'
            dates = self.date_search
            search_hash[:start_date] = dates[:start_date]
            search_hash[:end_date] = dates[:end_date]
          when 'keyword'
            search_hash[:keyword] = self.keyword_search
          else
            puts "Sorry we did not recogise your input"
        end #end of switch statement
      end #end of if statement
    end #end of while loop
    # binding.pry
    search_hash
  end #end of search class

  def self.subject
    puts''
      puts "What subject would you like to search for ?"
      subject = CLI.gets_with_quit
  end

  def self.headline_search
    puts''
    puts 'What headline would you like to search for ?'
    headline = CLI.gets_with_quit
  end

  def self.date_search
    puts''
    puts "What start date would you like ? yyyymmdd"
    start_date = CLI.gets_with_quit
    puts''
    puts "What end date would you like ? yyyymmdd"
    end_date = CLI.gets_with_quit
    {start_date: start_date, end_date: end_date}
  end

  def self.keyword_search
    puts''
    puts "What keyword would you like to search by ?"
    keyword = CLI.gets_with_quit
  end
end
