module ArticlesModule
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def self.show_all_favourited
      Article.all.map do |article|
        puts article.title
      end
    end

  end


    def print
      system("clear")
      puts ""
      puts "Title:".green.bold +  " #{self.users_title}" unless self.users_title.nil?
      puts "Headline:".green.bold +  " #{self.headline}\n" unless self.headline.nil?
      puts ""
      puts "Summary:".green.bold +  " #{self.snippet}" unless self.snippet.nil?
      puts "Source : ".green.bold +  "#{self.source}" unless self.source.nil?
      puts ""
      puts "Credit:".green.bold +  " #{self.credit}" unless self.credit.nil?
      puts ""
    end

    def open
      Launchy.open(self.url)
    end

    def article_options
      self.print
      list_message = "What would you like to do to your article?"
      options = ["Open", "rename", "(Un)favourite", "Back to menu"]
      choice = PROMPT.select(list_message, options)
      case options.index(choice)
      when 0
         self.open
       when 1
         self.name_article
       when 2
          if CLI.active_user.articles.include?(self)
            self.delete
          else
            self.save_article
          end
       when 3
         CLI.user_options
      end
       CLI.user_options
     end

     def name_article
       puts "What title would you like to give this article"
       title = gets.chomp
       self.users_title = title
       self.save
     end

  



end #end of all modules
