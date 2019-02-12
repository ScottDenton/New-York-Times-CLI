class Article < ActiveRecord::Base
  has_many :users, through: :user_articles
  serialize :search_query
end
