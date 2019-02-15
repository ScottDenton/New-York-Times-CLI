class Article < ActiveRecord::Base
  include ArticleControls
  has_many :user_articles
  has_many :users, through: :user_articles

  # Given an article represented as JSON
  # extract the relevant information, which may
  # or may not exist depending upon the individual
  # article returned by the API
  # .parse : (JSON) -> Article: instance
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

  # When given new article from API
  # Name article and add current user to
  # list of associated users
  # #save_article : -> Article: instance
  def save_article
    self.name_article
    self.users << CLI.active_user
    self.save
  end

  # When favouriting already saved article
  # Omit changing name and simply add current
  # user to list of associated users
  # #favourite_article : -> Article: instance
  def favourite_article
    self.users << CLI.active_user
    self.save
  end

end# end of class
