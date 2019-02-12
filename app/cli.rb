class CLI

   def intro


   end

   def help

   end

   def list_topics

   end

   class Search

     def self.subject
         puts "What subject would you like to search for ?"
         subject = gets.chomp.downcase
     end

     def self.date
       puts "Would you like to input a search date ?(y/n)"
       answer = gets.chomp.downcase
       if answer == 'y'
         puts "What date would you like to search from"
         date = gets.chomp
       else
        date = nil
       end
     end

   end #end of search class

end #end of CLI class
