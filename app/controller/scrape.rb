class Scrape

  # Scrapes a given webpage and returns a Nokogiri instance
  # filtered according to a CSS selector string
  # .scrape_page : (String, String) -> Nokogiri: instance
  def self.scrape_page(url, css)
   html = HTTParty.get(url)
   scraped_page = Nokogiri::HTML(html)
   scraped_page.css(css)
  end

  # Given a url from the NYT webpage, finds article paragraphs
  # and returns the first 3 sentences of the article.
  # .snipped : (String) -> String
  def self.snippet(url)
    page = self.scrape_page(url, ".css-1ygdjhk")
    article = ""
    page.each do |el|
      text = el.children.reduce("") {|text, child| text += "#{child.text}" }
      article << text
    end
    article = article.split(/(?<=[\.!?])/)
    article[0..3].join(" ")
  end

end