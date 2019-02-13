class CLI

  def main_loop
  end
   def intro


   end

   def help

   end

   def list_topics

   end

   def self.start
     search = Search.search_loop

     query = Query.build_query(search)
     json = Query.request(query)
     parsed = Query.parse(json)
     articles = parsed["response"]["docs"]

     CLI.list_articles(articles)
     self.start
   end

   def self.list_articles(articles)
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



end #end of CLI class
