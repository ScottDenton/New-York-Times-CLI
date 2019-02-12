class CLI

   def intro


   end

   def help

   end

   def list_topics

   end

   class Search
     def self.search_loop
       search_hash = {}
       search_hash[:subject] = self.subject
       while true
         puts "Would you like to refine your search ? (y/n)"
         refine = gets.chomp.downcase
         if refine == 'n'
           break
         else
           puts "What criteria would you like to add?"
           puts "Location - Date - Keyword - Category"
           criteria = gets.chomp.downcase

           case criteria
           when 'location'
             self.location_search
           when 'date'
             dates = self.date_search
             search_hash[:start] = dates[0]
             search_hash[:end] = dates[1]
           when 'keyword'
             self.keyword_search
           when 'category'
             self.category_search
           else
             puts "Sorry we did not recogise your input"
           end

         end


       end
       search_hash
     end

     def self.location_search
       puts 'location search'
     end

     def self.date_search
       puts "What start date would you like ? yyyymmdd"
       start_date = gets.chomp.downcase
       puts "What end date would you like ? yyyymmdd"
       end_date = gets.chomp.downcase
       date = [start_date, end_date]

     end

     def self.keyword_search
       puts 'keyword search'
     end

     def self.category_search
       puts 'category search'
     end

     def self.subject
         puts "What subject would you like to search for ?"
         subject = gets.chomp.downcase
     end

     def self.date
       puts "Would you like to input a search date ?(y/n)"
       answer = gets.chomp.downcase
       if answer == 'y'
         puts "What date would you like to search from (yyyymmdd)"
         date = gets.chomp
       else
        date = nil
       end
     end
   end #end of search class

end #end of CLI class
