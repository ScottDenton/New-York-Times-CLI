class CLI

  def self.main_loop
  end
  def self.intro
  end

  def self.help
  end

  def self.list_topics
  end

  def self.yes_no(message)
    puts "#{message} (y/n)?"
    response = gets.chomp.downcase
    if response =~ /y|yes/
      true
    elsif response =~ /n|no|^.{0}$/
      false
    else
      puts "Sorry, we didn't get that"
      return yes_no(message)
    end
  end

  def self.start
    self.intro
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

      parsed_article.open if self.yes_no("Open Article")

      parsed_article.save if self.yes_no("Save Article")

      exit if self.yes_no("Exit")
    end
  end
end #end of CLI class
