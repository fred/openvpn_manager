class User < ActiveRecord::Base
  include Clearance::User
  
  attr_accessible :email, :name, :password, :password_confirmation
  
  after_create :activate
  
  def activate
    self.confirm_email!
  end
  
  
end
