class CLI

  def main_loop
  end
   def intro


   end

   def help

   end

   def list_topics

   end

   def list_articles(articles)
     articles.each do |article|
       parsed_article = Article.parse(article)
       parsed_article.print

       puts 'Open Article (y/n)?'
       open = gets.chomp.downcase
       if open == 'y'
         parsed_article.open
       end

       puts 'Save Article (y/n)?'
       save = gets.chomp.downcase
       if save == 'y'
         parsed_article.save
       end
     end
   end

   class Search
     def self.search_loop
       search_hash = {}
       search_hash[:subject] = self.subject
       while true
         puts''
         puts "Would you like to refine your search ? (y/n)"
         refine = gets.chomp.downcase
         if refine == 'n'
           break
         else
           puts ''
           puts "What criteria would you like to add?"
           puts "Headline - Date - Keyword"
           criteria = gets.chomp.downcase

           case criteria
           when 'headline'
            search_hash[:headline] =  self.headline_search
           when 'date'
             dates = self.date_search
             search_hash[:start_date] = dates[0]
             search_hash[:end_date] = dates[1]
           when 'keyword'
             search_hash[:keyword] = self.keyword_search
           # when 'category'
           #   search_hash[:category] = self.category_search
           else
             puts "Sorry we did not recogise your input"
           end #end of switch statement
         end #end of if statement
       end #end of while loop
       # binding.pry
       search_hash
     end #end of search class

     def self.headline_search
       puts''
       puts 'What headline would you like to search for ?'
       headline = gets.chomp.downcase
     end

     def self.date_search
       puts''
       puts "What start date would you like ? yyyymmdd"
       start_date = gets.chomp.downcase
       puts''
       puts "What end date would you like ? yyyymmdd"
       end_date = gets.chomp.downcase
       date = [start_date, end_date]
     end

     def self.keyword_search
       puts''
       puts "What keyword would you like to search by ?"
       keyword = gets.chomp.downcase
     end

     # def self.category_search
     #   puts''
     #   puts 'What category would you like to search ?'
     #   category = gets.chomp.downcase
     # end

     def self.subject
       puts''
         puts "What subject would you like to search for ?"
         subject = gets.chomp.downcase
     end



   end #end of search class

end #end of CLI class
