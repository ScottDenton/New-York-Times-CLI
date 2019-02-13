class User < ActiveRecord::Base
  has_many :user_articles
  has_many :articles, through: :user_articles
end
