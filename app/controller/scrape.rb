require 'nokogiri'
require 'httparty'
require 'pry'

class Scrape

  def self.scrape_page(url, css)
   html = HTTParty.get(url)
   scraped_page = Nokogiri::HTML(html)
   scraped_page.css(css)
  end

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