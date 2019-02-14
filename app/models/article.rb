class Article < ActiveRecord::Base
  include ArticleControls
  has_many :user_articles
  has_many :users, through: :user_articles


  def self.parse(article)
    new_article = self.new()
    new_article.url ||= article['web_url']
    new_article.snippet ||= article['lead_paragraph']
    new_article.source ||= article['source']
    new_article.headline ||= article['headline']['main']
    if article['multimedia'] && article['multimedia'][1]
      new_article.credit ||= article['multimedia'][1]['credit']
    end
    new_article
  end


  def save_article
    self.name_article
    self.users << CLI.active_user
    self.save
  end

end# end of class
