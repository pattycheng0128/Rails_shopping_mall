class User < ApplicationRecord
  validates :name, :email, presence: true

  before_create :encryted_password

  def self.login(user_info)
    email = user_info[:email]
    password = user_info[:password]

    salted_password = "xy#{password.reverse}hello"
    encryted_password = Digest::SHA2.hexdigest(salted_password)

    self.find_by(email: email, password: encryted_password)
  end

  def encryted_password
    salted_password = "xy#{self.password.reverse}hello"
    self.password = Digest::SHA2.hexdigest(salted_password)
  end

end
