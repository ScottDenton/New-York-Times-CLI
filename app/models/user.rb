class User < ActiveRecord::Base
  include UserControls
  has_many :user_articles
  has_many :articles, through: :user_articles


   include BCrypt

   def get_password
       @password_hash ||= Password.new(password)
     end

     def set_password=(new_password)
       @password_hash = Password.create(new_password)
       self.password = @password_hash
     end



  def self.find_user(name)
    self.all.find{|user| user.name == name}
  end
end
