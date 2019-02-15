class User < ActiveRecord::Base
  include UserControls
  include BCrypt

  has_many :user_articles
  has_many :articles, through: :user_articles


  # Loads hashed password from database
  # Instantiates BCrypt password object
  # and returns. BCrypt object allows == comparison
  # #get_password : -> BCrypt Password: Instance
  def get_password
    self.reload
    Password.new(self.password)
  end

  # Hashes string and saves to user record on db
  # #set_password= : (String) -> User: instance
  def set_password=(new_password)
    self.password = Password.create(new_password)
    self.save
  end

  # .find_user : (String) -> User: instance
  def self.find_user(name)
    self.all.find{|user| user.name == name}
  end
end
