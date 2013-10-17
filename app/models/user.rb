class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :commentvotes
  has_many :postvotes

    include BCrypt

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def self.authenticate(name, password)
    user = User.find_by_name(name)
    return user if user && (user.password == password)
    nil
  end
end



# Add the gem in the Gemfile (Gemfile)
# #ADD THIS=> gem 'bcrypt-ruby'

# Require BCrypt here (config > environment.rb)
# #ADD THIS=> require 'bcrypt'

# Add BCrypt methods to the ‘User’ model
# #COPY EVERYTHING BELOW
# include BCrypt

# def password
#   @password ||= Password.new(password_digest)
# end

# def password=(new_password)
#   @password = Password.create(new_password)
#   self.password_digest = @password
# end

# def self.authenticate(email, password) 
#   user = User.find_by_email(email)
#   return user if user && (user.password == password)
#   nil
# end

# MIGRATION ATTRIBUTE CHANGE (User)

# Change this => t.string = :password
# To this =====> t.string = :password_digest

# MAKE SURE YOU RE-MIGRATE YOUR TABLES TO REFLECT PREVIOUS CHANGE!!!
