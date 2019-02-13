class User < ActiveRecord::Base
  has_many :user_articles
  has_many :articles, through: :user_articles

  def list_own_articles

  end

  def find_article

  end

  def self.find_user(name)
    self.all.find{|user| user.name == name}
  end

  def self.check_login(name)
    self.all.any?{|user| user.name == name}
  end

  def self.signup_user
    puts "Please enter your name to signup"
    name = CLI.gets_with_quit
    if self.check_login(name)
      puts "Sorry that name is already taken :("
      self.signup_user
    else
      user =  User.create(name: name)
      CLI.active_user = user
    end
  end

  def self.login
    puts "Please enter your name"
    name = CLI.gets_with_quit
    user = self.find_user(name)
    CLI.active_user = user
  end

end
