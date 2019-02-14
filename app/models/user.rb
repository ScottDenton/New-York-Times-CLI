class User < ActiveRecord::Base
  include UserControls
  has_many :user_articles
  has_many :articles, through: :user_articles

  def self.find_user(name)
    self.all.find{|user| user.name == name}
  end
end
